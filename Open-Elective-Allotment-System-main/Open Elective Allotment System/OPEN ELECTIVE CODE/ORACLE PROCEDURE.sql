CREATE OR REPLACE PROCEDURE open_allotment AS

    c_capacity NUMBER;
    CURSOR allotment_rec IS
    SELECT
        name,
        urn,
        cpi,
        branch,
        choice1,
        choice2,
        choice3
    FROM
        choices
    ORDER BY
        cpi DESC,
        timestamp;

BEGIN
    FOR c IN allotment_rec LOOP
        SELECT
            capacity
        INTO c_capacity
        FROM
            courses
        WHERE
            course = c.choice1;

        IF ( c_capacity > 0 ) THEN
            INSERT INTO allotment VALUES (
                c.name,
                c.urn,
                c.branch,
                1,
                c.choice1
            );

            UPDATE courses
            SET
                capacity = capacity - 1
            WHERE
                course = c.choice1;

        ELSE
            SELECT
                capacity
            INTO c_capacity
            FROM
                courses
            WHERE
                course = c.choice2;

            IF ( c_capacity > 0 ) THEN
                INSERT INTO allotment VALUES (
                    c.name,
                    c.urn,
                    c.branch,
                    2,
                    c.choice2
                );

                UPDATE courses
                SET
                    capacity = capacity - 1
                WHERE
                    course = c.choice2;

            ELSE
                SELECT
                    capacity
                INTO c_capacity
                FROM
                    courses
                WHERE
                    course = c.choice3;

                IF ( c_capacity > 0 ) THEN
                    INSERT INTO allotment VALUES (
                        c.name,
                        c.urn,
                        c.branch,
                        3,
                        c.choice3
                    );

                    UPDATE courses
                    SET
                        capacity = capacity - 1
                    WHERE
                        course = c.choice3;

                ELSE
                    INSERT INTO allotment VALUES (
                        c.name,
                        c.urn,
                        c.branch,
                        NULL,
                        'No Course Alloted'
                    );

                END IF;

            END IF;

        END IF;

    END LOOP;

    COMMIT;
END;