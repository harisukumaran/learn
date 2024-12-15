IDENTIFICATION DIVISION.
       PROGRAM-ID. NachaParser.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT NACHA-FILE ASSIGN TO 'NACHAIN'
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  NACHA-FILE.
       01  NACHA-RECORD PIC X(80).

       WORKING-STORAGE SECTION.
       01  WS-EOF            PIC X VALUE 'N'.
           88  WS-EOF-YES    VALUE 'Y'.
           88  WS-EOF-NO     VALUE 'N'.
       01  WS-SEGMENT        PIC X(80).
       01  WS-ELEMENTS.
           05  WS-ELEMENT     OCCURS 10 TIMES
               INDEXED BY WS-ELEMENT-INDEX
               PIC X(20).

       PROCEDURE DIVISION.
           OPEN INPUT NACHA-FILE
           PERFORM UNTIL WS-EOF-YES
               READ NACHA-FILE
                   AT END
                       SET WS-EOF-YES TO TRUE
                   NOT AT END
                       MOVE NACHA-RECORD TO WS-SEGMENT
                       IF WS-SEGMENT(1:3) = 'RMR'
                           PERFORM PARSE-RMR-SEGMENT
                       END-IF
               END-READ
           END-PERFORM
           CLOSE NACHA-FILE
           STOP RUN.

       PARSE-RMR-SEGMENT.
           UNSTRING WS-SEGMENT DELIMITED BY '*'
               INTO WS-ELEMENT (1)
                    WS-ELEMENT (2)
                    WS-ELEMENT (3)
                    WS-ELEMENT (4)
           DISPLAY 'Account Number: ' WS-ELEMENT (3)
           DISPLAY 'Payment Amount: ' WS-ELEMENT (4).
