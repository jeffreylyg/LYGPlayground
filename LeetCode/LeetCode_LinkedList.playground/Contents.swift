//: Playground - noun: a place where people can play

import UIKit

public class ListNode {
	public var val: Int
	public var next: ListNode?
	public init(_ val: Int) {
		self.val = val
		self.next = nil
	}
}

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
	let dumy = ListNode(0)
	dumy.next = head
	
	var prev: ListNode? = dumy
	var post: ListNode? = dumy
	
	for _ in 0 ..< n {
		prev = prev?.next
	}
	
	while prev?.next != nil {
		prev = prev?.next
		post = post?.next
	}
	
	post?.next = post?.next?.next
	
	return dumy.next
}

func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
	guard let cl1 = l1, let cl2 = l2 else {
		if l1 != nil {
			return l1
		} else if l2 != nil {
			return l2
		} else {
			return nil
		}
	}
	
	var head: ListNode?
	
	if cl1.val < cl2.val {
		head = cl1
	} else {
		head = cl2
	}
	
	return head
}

func reverseList(_ head: ListNode?) -> ListNode? {
	var prevNode: ListNode? = nil
	var nextNode: ListNode? = nil
	var currentNode: ListNode? = head
	
	while currentNode != nil {
		nextNode = currentNode?.next
		currentNode?.next = prevNode
		
		prevNode = currentNode
		currentNode = nextNode
	}
	
	return prevNode
}

func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
	var mNode: ListNode?
	var mPrevNode: ListNode?
	
	for i in 1 ... m {
		if i == 1 {
			mNode = head
		} else {
			mPrevNode = mNode
			mNode = mNode?.next
		}
	}
	
	var prevNode: ListNode?
	var nNode: ListNode?
	var nPostNode: ListNode?
	
	nNode = mNode
	for _ in m ... n {
		nPostNode = nNode?.next
		nNode?.next = prevNode
		
		prevNode = nNode
		nNode = nPostNode
	}
	nNode = prevNode
	
	mPrevNode?.next = nNode
	mNode?.next = nPostNode
	
	if m == 1 {
		return nNode
	}
	
	return head
}

func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
	var count = 0
	var current: ListNode? = head
	while current != nil {
		count += 1
		current = current?.next
	}
	
	let realK = k % count
	
	if realK == 0 {
		return head
	}
	
	let dumy = ListNode(0)
	dumy.next = head
	
	var prev: ListNode? = dumy
	var post: ListNode? = dumy
	
	for _ in 0..<realK {
		prev = prev?.next
	}
	
	while prev?.next != nil {
		prev = prev?.next
		post = post?.next
	}
	
	prev?.next = head
	dumy.next = post?.next
	post?.next = nil
	
	return dumy.next
}
