package org.example;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class NachaParser {
    public static void main(String[] args) {
        String filePath = "path/to/nacha/file.txt"; // Update with the actual file path

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.startsWith("RMR")) {
                    parseRmrSegment(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void parseRmrSegment(String segment) {
        // Assuming the segment is delimited by '*'
        String[] elements = segment.split("\\*");
        if (elements.length >= 4) {
            String accountNumber = elements[2];
            String paymentAmount = elements[3];
            System.out.println("Account Number: " + accountNumber);
            System.out.println("Payment Amount: " + paymentAmount);
        } else {
            System.out.println("Invalid RMR segment: " + segment);
        }
    }
}
