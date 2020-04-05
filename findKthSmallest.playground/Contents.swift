import UIKit

var str = "Hello, playground"

/// This algorithm uses QuickSelect (Similar to QuickSort) to find the kth smallest item in the given array.
/// Runtime of the algorithm is O(nlogk).
/// - Parameters:
///   - nums: Array of Integers
///   - k: Smallest number after k amount of smaller numbers in the array.
func findKthSmallest(nums: [Int], k: Int) -> Int {
    precondition(k >= 1 && k <= nums.count, "k must be in the range 1 ... count")
    
    var nums = nums // mutable copy
    var low = 0
    var high = nums.count
    
    while high - low > 1 {
        // Choose a random pivot element
        let randomElement = nums[Int.random(in: low..<high)]
        
        // Partition elements such that:
        // nums[i] < pivotElement  for low <= i < pivotIndex,
        // nums[i] >= pivotElement for pivotIndex <= i < high.
        var pivotIndex = low
        while nums[pivotIndex] < randomElement {
            pivotIndex += 1
        }
        
        for i in pivotIndex+1 ..< high {
            if nums[i] < randomElement {
                nums.swapAt(pivotIndex, i)
                pivotIndex += 1
            }
        }
        
        if k <= pivotIndex {
            // k-smallest element is in the first partition.
            high = pivotIndex
        }
        else if k > pivotIndex + 1 {
            low = pivotIndex
            while nums[low] == randomElement, k - low > 1 {
                low += 1
            }
        }
        else {
            // Pivot element is the k-smallest
            return randomElement
        }
    }
    // Only single candidate left:
    return nums[low]
}

let kthSmallestArray = [1, 2, 4, 8, 9, 12, 14, 18]
let k = 4
let kthSmallest = findKthSmallest(nums: kthSmallestArray, k: k)
