//: Playground - noun: a place where people can play

import UIKit

public class TreeNode {
	public var val: Int
	public var left: TreeNode?
	public var right: TreeNode?
	public init(_ val: Int) {
		self.val = val
		self.left = nil
		self.right = nil
	}
}

/* 94. Binary Tree Inorder Traversal */
func inorderTraversal(_ root: TreeNode?) -> [Int] {
	var result: [Int] = []
	var stack: [TreeNode] = []
	
	guard let root = root else { return result }
	
	stack.append(root)
	while !stack.isEmpty {
		let top = stack.last!
		if let left = top.left {
			stack.append(left)
			top.left = nil
		} else {
			result.append(top.val)
			stack.removeLast()
			if let right = top.right {
				stack.append(right)
			}
		}
	}
	
	return result
}

/* 98. Validate Binary Search Tree */
func isValidBST(_ root: TreeNode?) -> Bool {
	return isValid(root, low: Int.min, high: Int.max)
}

private func isValid(_ root: TreeNode?, low: Int, high: Int) -> Bool {
	guard let root = root else { return true }
	if root.val <= low || root.val >= high { return false }
	return isValid(root.left, low: low, high: root.val) && isValid(root.right, low: root.val, high: high)
}

/* 102. Binary Tree Level Order Traversal */
func levelOrder(_ root: TreeNode?) -> [[Int]] {
	var result: [[Int]] = []
	var queue: [TreeNode] = []
	guard let root = root else { return result }
	
	queue.append(root)
	while !queue.isEmpty {
		let count = queue.count
		var level: [Int] = []
		
		for _ in 0..<count {
			let head = queue.removeFirst()
			level.append(head.val)
			
			if let left = head.left {
				queue.append(left)
			}
			
			if let right = head.right {
				queue.append(right)
			}
		}
		
		result.append(level)
	}
	
	return result
}

/* 103. Binary Tree Zigzag Level Order Traversal */
func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
	var result: [[Int]] = []
	var currentStack: [TreeNode] = []
	var nextStack: [TreeNode] = []
	guard let root = root else { return result }
	
	var forwardDirection: Bool = true
	currentStack.append(root)
	while !currentStack.isEmpty {
		let count = currentStack.count
		var level: [Int] = []
		
		for _ in 0..<count {
			let node = currentStack.removeLast()
			level.append(node.val)
			if forwardDirection {
				if let left = node.left {
					nextStack.append(left)
				}
				
				if let right = node.right {
					nextStack.append(right)
				}
			} else {
				if let right = node.right {
					nextStack.append(right)
				}
				
				if let left = node.left {
					nextStack.append(left)
				}
			}
		}
		
		result.append(level)
		
		forwardDirection = !forwardDirection
		currentStack = nextStack
		nextStack.removeAll()
	}
	
	return result
}

/* 107. Binary Tree Level Order Traversal II */
func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
	var result: [[Int]] = []
	var queue: [TreeNode] = []
	guard let root = root else { return result }
	
	queue.append(root)
	while !queue.isEmpty {
		let count = queue.count
		var level: [Int] = []
		
		for _ in 0..<count {
			let head = queue.removeFirst()
			level.append(head.val)
			
			if let left = head.left {
				queue.append(left)
			}
			
			if let right = head.right {
				queue.append(right)
			}
		}
		
		result.insert(level, at: 0)
	}
	
	return result
}

/* 110.Balanced Binary Tree */
func isBalanced(_ root: TreeNode?) -> Bool {
	guard let root = root else {
		return true
	}
	
	if checkHeight(root) == -1 {
		return false
	} else {
		return true
	}
}

private func checkHeight(_ root: TreeNode?) -> Int {
	guard  let root = root else {
		return 0
	}
	
	let leftHeight = checkHeight(root.left)
	if leftHeight == -1 { return -1 }
	
	let rightHeight = checkHeight(root.right)
	if rightHeight == -1 { return -1 }
	
	if abs(leftHeight - rightHeight) > 1 { return -1 }
	
	return max(leftHeight, rightHeight) + 1
}

/* 114. Flatten Binary Tree to Linked List */
func flatten(_ root: TreeNode?) -> Void {
	if let root = root {
		preorderTraversal(root, root)
	}
}

private func preorderTraversal(_ node: TreeNode?, _ root: TreeNode) {
	if let node = node {
		preorderTraversal(node.left, root)
		preorderTraversal(node.right, root)
	}
}

/* 404. Sum of Left Leaves */
func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
	guard let root = root else {
		return 0
	}
	
	let leftNode = root.left
	if leftNode != nil && leftNode?.left == nil && leftNode?.right == nil {
		return leftNode!.val + sumOfLeftLeaves(root.right)
	}
	
	let left = sumOfLeftLeaves(root.left)
	let right = sumOfLeftLeaves(root.right)
	
	return left + right
}
