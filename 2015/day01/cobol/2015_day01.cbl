       IDENTIFICATION DIVISION.
       PROGRAM-ID. AoC_2015_day01.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE
           ASSIGN TO "../input.txt"
           ORGANIZATION IS SEQUENTIAL
           FILE STATUS IS FILE-STATUS.

       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE.
       01  INPUT-CHAR  PIC X.

       WORKING-STORAGE SECTION.
       01 FILE-STATUS PIC X(2).
           88 FILE-OK  VALUE "00".
           88 FILE-EOF VALUE "10".
       01 FLOOR PIC S9(8) VALUE 0.
           88 UNDERGROUND VALUES -99999999 THRU -1.
       01 STEPS PIC 9(8) VALUE 0.
       01 LOCATION PIC 9(8) VALUE 0.
           88 FIRST-TIME VALUE 0.

       PROCEDURE DIVISION.
       MAIN.
           PERFORM OPEN-FILE
           PERFORM READ-STEPS UNTIL FILE-EOF
           DISPLAY "Santa ends on floor: " FLOOR
           DISPLAY "Santa goes to the basement at step: " LOCATION
           PERFORM CLOSE-FILE
           STOP RUN.

       OPEN-FILE.
           OPEN INPUT INPUT-FILE
           IF NOT FILE-OK
               DISPLAY "Error opening file. Status: " FILE-STATUS
               STOP RUN
           END-IF.

       READ-STEPS.
           READ INPUT-FILE
               NOT AT END
                   PERFORM PROCESS-STEP
           END-READ.

       PROCESS-STEP.
           ADD 1 TO STEPS.

           EVALUATE INPUT-CHAR
               WHEN "("
                   ADD 1 TO FLOOR
               WHEN ")"
                   SUBTRACT 1 FROM FLOOR
           END-EVALUATE.

           IF UNDERGROUND AND FIRST-TIME
               MOVE STEPS TO LOCATION
           END-IF.

       CLOSE-FILE.
           CLOSE INPUT-FILE.
