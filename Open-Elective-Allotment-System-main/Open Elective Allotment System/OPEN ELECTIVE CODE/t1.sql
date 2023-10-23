BEGIN 
	DECLARE n_name, b_branch, c1, c2, c3 TEXT;
	DECLARE u_urn, c_cpi, c_capacity INT;
	DECLARE exit_loop BOOLEAN;
    DECLARE inner_exit BOOLEAN;
	DECLARE allotment_cursor CURSOR FOR 
    SELECT NAME, URN,CPI, BRANCH, CHOICE_1, CHOICE_2, CHOICE_3
    FROM CHOICES
    ORDER BY 
    cpi DESC,
    timestamp;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    OPEN allotment_cursor;
        a_loop: LOOP
            FETCH FROM allotment_cursor 
            INTO n_name,u_urn,c_cpi, b_branch, c1, c2, c3;
            IF exit_loop THEN
                LEAVE a_loop;
            ELSE 
                IF
                DECLARE allotment_ref CURSOR     
                FOR SELECT a,b from CHOICES a , courses b
                WHERE b.course=a.CHOICE_1;





                DECLARE CONTINUE HANDLER FOR NOT FOUND SET inner_exit=TRUE;

                OPEN allotment_ref;
                b_loop: LOOP
                    FETCH FROM allotment_ref INTO c_capacity
                    FROM courses
                    WHERE course=choices.CHOICE_1;
                    IF inner_exit THEN
                        LEAVE b_loop;
                    ELSE
                        IF (c_capacity > 0) THEN
                            INSERT INTO allotment VALUES
                            (
                                n_name, 
                                u_urn, 
                                b_branch, 
                                '1',
                                choices.CHOICE_1
                            );
                            UPDATE courses
                            SET capacity = capacity-1;
                            WHERE course=choices.CHOICE_1;





                            

                        ELSE
                            FETCH FROM allotment_ref INTO c_capacity
                            FROM courses
                            WHERE course=choices.CHOICE_2;

                            IF (c_capacity > 0) THEN
                            INSERT INTO allotment VALUES
                            (
                                n_name, 
                                u_urn, 
                                b_branch, 
                                '2',
                                choices.CHOICE_2
                            );
                            UPDATE courses
                            SET capacity = capacity-1;
                            WHERE course=choices.CHOICE_2;
                            
                            ELSE
                                FETCH FROM allotment_ref INTO c_capacity
                                FROM courses
                                WHERE course=choices.CHOICE_3;

                                IF (c_capacity > 0) THEN
                                INSERT INTO allotment VALUES
                                (
                                    n_name, 
                                    u_urn, 
                                    b_branch, 
                                    '3',
                                    choices.CHOICE_3
                                );
                                UPDATE courses
                                SET capacity = capacity-1;
                                WHERE course=choices.CHOICE_3;

                                ELSE
                                INSERT INTO allotment
                                VALUES(n_name, u_urn, b_branch, NULL ,'NO COURSE ALLOTED');
                            END IF;
                        END IF;
                    END IF;       
            END IF;
        END LOOP b_loop;    
        END LOOP a_loop;
    CLOSE allotment_ref;
    CLOSE allotment_cursor;
END;