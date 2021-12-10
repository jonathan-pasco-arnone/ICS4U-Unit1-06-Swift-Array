/*
* This is a program that calculates mean, median and mode
* after reading in a text file into an array.
*
* @author  Jonathan Pasco-Arnone
* @version 1.0
* @since   2021-11-26
*/

import Foundation

// Mean.
func mean(arrayOfNumbers: [Int], quantity: Int) throws -> Double {
    // Variables.
    var sum = 0
    // Constants
    let mean: Double

    for counter in arrayOfNumbers {
        sum += counter
    }
    mean = Double(sum) / Double(quantity)

    return mean
}

// Median.
func median(arrayOfNumbers: [Int], quantity: Int) throws -> Double {
    // Variables.
    var returnValue: Double
    var array = arrayOfNumbers
    var median: Double
    let extra: Double = 0.5

    array.sort()

    if quantity % 2 == 0 {
        median = Double(array[quantity / 2])
        returnValue = median
    } else {
        median = Double((array[Int(Double(quantity) / 2 - extra)]) +
           (array[Int(Double(quantity) / 2 + extra)])) / 2
        returnValue = median
    }

    return returnValue
}

// Mode.
func mode(arrayOfNumbers: [Int], quantity: Int) throws -> [Int] {
    // Variables.
    var modes = Set<Int>()
    var array = arrayOfNumbers
    var maxCount = 0

    modes = [0]
    array.sort()

    for counterOne in array {
        var currentCount = 0

        // If the first value of the array equals any of the others
        // it will add to the count.
        for counterTwo in array where counterOne == counterTwo {
            currentCount += 1
        }

        // If the current count is a new max count,
        // then it will replace the old one
        if currentCount > maxCount {
            maxCount = currentCount
            modes.removeAll()
            modes.insert(counterOne)
        } else if currentCount == maxCount {
            if modes.contains(counterOne) != true {
                modes.insert(counterOne)
            }
        }
    }
    let returnValue = Array(modes)
    return returnValue
}

// Inputs.
let input = CommandLine.arguments
// This file will be read.
let file = input[1]
var array: [String] = []
var arrayInt: [Int] = []

// FileManager lets me read files in swift
// It reads a file from the document Directory in home.
if let dir = FileManager.default.urls(for: .documentDirectory,
                                      in: .userDomainMask).first {

    // This adds a trailing "/" if the path component is a directory.
    let fileURL = dir.appendingPathComponent(file)
    do {
        // Read file.
        let text = try String(contentsOf: fileURL, encoding: .utf8)

        // Makes an array from the values in the file,
        // and then separates each value by a new line.
        array = text.components(separatedBy: .newlines)

    // If the file cannot be read then it will print this error.
    } catch {print("File cannot be read properly.")}

// If the file cannot be found then it will print this error.
} else { print("File cannot be found.") }

for counter in array where !counter.isEmpty {
    arrayInt.append(Int(counter)!)
}
print(arrayInt)

let numberOfValues: Int = array.count

print("\nCalculating stats...")
let meanPrint = try mean(arrayOfNumbers: arrayInt, quantity: numberOfValues)
let medianPrint = try median(arrayOfNumbers: arrayInt, quantity: numberOfValues)
let modePrint = try mode(arrayOfNumbers: arrayInt, quantity: numberOfValues)

print("The mean is: ", meanPrint)
print("The median is: ", medianPrint)
print("The mode is: ", modePrint)

print("\nDone.\n")
