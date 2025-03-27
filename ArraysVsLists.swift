//
// ArraysVsLists.swift
//
// Created by Noah Smith
// Created on 2025-03-26
// Version 1.0
// Copyright (c) 2025 Noah Smith. All rights reserved.
//
// The ArraysVsLists program reads each text file containing a list of integers.
// It converts them into integers and puts them into an array.
// It then sorts the array and calculates the mean and median.
// It then displays the numbers sorted from smallest to largest.
// Finally, it displays the mean and median.
//

// Import foundation library
import Foundation

// Function to calculate the mean
func calcMean(arrayInt: [Int]) -> Double {

    // initialize the sum
    var sum = 0.0

    // iterate through the array
    for num in arrayInt {
        // add the integer of the current index to the sum
        sum += Double(num)
    }

    // return the mean
    return Double(sum) / Double(arrayInt.count)
}

// Function to calculate the median
func calcMedian(arrayInt: [Int]) -> Double {
    // Initialize the median
    var median = 0.0

    // If the length of the array is even
    if arrayInt.count % 2 == 0 {
        // find the two middle indexes
        let medianIndex1 = arrayInt.count / 2
        let medianIndex2 = medianIndex1 - 1

        // calculate the median
        median = Double((arrayInt[medianIndex1] + arrayInt[medianIndex2])) / 2.0
    } else {
        // If the length of the array is odd
        // find the middle index
        let medianIndex = arrayInt.count / 2

        // set the value at the middle index to the median
        median = Double(arrayInt[medianIndex])
    }

    // return the median
    return median
}

// Greet the user
print("Welcome to the Arrays vs Lists program!")

// initialize the file name outside of the loop
var fileName = ""

repeat {
    // Ask the user for the file name
    print("Enter the number set you would like to use (1, 2, 3), or 'q' to quit: ", terminator: "")

    // Get the file name input
    // If the user enters nothing, it will replace nil with an empty string
    fileName = readLine() ?? ""

    // Check if the user wants to quit
    if fileName == "q" {

        // goodbye message
        print("Goodbye!")
    } else if (fileName != "1") && (fileName != "2") && (fileName != "3") {

        // If the input is invalid
        print("Invalid input. Please enter a number set (1, 2, or 3).")
    } else {

        // Set the file name
        let fileNameWithPath = "Unit2-06-set\(fileName).txt"
        do {
            // Read the contents of the file
            let file = try String(contentsOfFile: fileNameWithPath, encoding: .utf8)

            // Initialize the array of numbers
            var numbers: [Int] = []

            // Split the file into lines
            let lines = file.split(separator: "\n")

            // Split each line into numbers
            for line in lines {

                // The numbers are separated by spaces
                let numberStrings = line.split(separator: " ")

                // Convert the strings of numbers to integers
                for numStr in numberStrings {

                    // Convert the string to an integer
                    if let number = Int(numStr) {

                        // Add the integer to the array
                        numbers.append(number)
                    }
                }
            }

            // Sort the array of numbers
            let sortedArray = numbers.sorted()

            // Call the mean and median from each function
            let mean = calcMean(arrayInt: sortedArray)
            let median = calcMedian(arrayInt: sortedArray)

            // Create the output file name
            let outputFileName = "Unit2-06-set\(fileName)-output.txt"

            // reset the output string
            var outputStr = ""

            // Write the sorted array directly to an output string
            // One number at a a time, separated by spaces
            // I didn't want to use an output string but this is the only way I could get it to work
            for number in sortedArray {
                // Write the number to the output file
                outputStr += String(number) + " "
            }

            // add a new line to the output string
            outputStr += "\n"

            // add the mean and median to the output string
            outputStr += "Mean: \(mean)\n"
            outputStr += "Median: \(median)\n"

            // Check for any errors
            do {

                // Source: https://developer.apple.com/documentation/foundation/nsstring/1497362-write
                // Write the output string to the output file
                // atomically means that the file will be written to a temporary file first
                // It does this to prevent any loss of data if the write fails, or if it gets overwritten
                try outputStr.write(toFile: outputFileName, atomically: true, encoding: .utf8)

                // Success message
                print("The file " + fileNameWithPath + " was written successfully.")
            } catch {
                // If the file cannot be written
                print("Error writing to file.")
            }
        } catch {
            // If the file cannot be read
            print("Error writing to file.")
        }
    }

// Keep looping until the user enters 'q'
} while fileName != "q"
