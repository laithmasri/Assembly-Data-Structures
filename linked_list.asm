.data
.text

.globl LL_PUSH_FRONT
.globl LL_COUNT
.globl LL_SEARCH
.globl LL_INDEX
.globl LL_GREATER_OR_EQUAL
.globl LL_REVERSE

# -----------------------------------------------------------------------------
# Push a integer to the front of the given linked list.
# Allocates memory for the linked list node on the heap.
#
# Pre:
#       - $a0 contains the address of the start of the linked list
#       - $a1 contains the integer to add to the node
# Post:
#       - $a0 contains the new address of the start of the linked list
# -----------------------------------------------------------------------------
LL_PUSH_FRONT:
        # -- START SOLUTION --
        mv s0, a0
        li a7, 9
        li a0, 8
        ecall
        sw a1, 0(a0)
        sw s0, 4(a0)
        # -- END SOLUTION --
        jr ra, 0


# -----------------------------------------------------------------------------
# Return the length of the given linked list.
# The length of the linked list is the number of nodes it contains.
# A list with only the sentinel node has length 0.
#
# Pre:
#       - $a0 contains the address of the head of the linked list
# Post:
#       - $a0 contains the length of the linked list
# -----------------------------------------------------------------------------
LL_COUNT:
        # -- START SOLUTION --
        mv s0, a0
        lw s0, 4(s0)
        li t0, 0
        li t1, 0
        WHILE_LOOP:
        beq s0, t0, END
        lw s0, 4(s0)
        addi t1, t1, 1
        j WHILE_LOOP
        END:
       mv a0, t1
        # -- END SOLUTION --
        jr ra, 0


# -----------------------------------------------------------------------------
# Return the lowest index of the given integer in the list.
# Return -1 if the integer is not found.
#
# Pre:
#       - $a0 contains the address of the head of the linked list
#       - $a1 contains the integer to search for in the list
# Post:
#       - $a0 contains the lowest index of the integer if found, -1 otherwise
# -----------------------------------------------------------------------------
LL_SEARCH:
        # -- START SOLUTION --
        mv s0, a0
        mv s1, a1
        li t0, 0
        li t1, 0
        SEARCHING_LOOP:
        lw s2, 0(s0)
        beq s2, a1, FOUND_ITEM
        lw s2, 4(s0)
        beq s2, zero, END_SEARCH
        addi t1, t1, 1
        mv s0, s2
        j SEARCHING_LOOP

        END_SEARCH:
        li a0, -1
        j FINISHED_PROCEDURE

        FOUND_ITEM:
        mv a0, t1

        FINISHED_PROCEDURE:
        # -- END SOLUTION --
        jr ra, 0


# -----------------------------------------------------------------------------
# Return the integer at the given index in the list, and an integer indicating
# success/failure.
#
# The first integer is at index 0, second integer at index 1, and so forth.
# The index is invalid if it is greater or equal to the length of the list.
#
# Pre:
#       - $a0 contains the address of the start of the linked list
#       - $a1 contains the index of the list to retrieve
#       - The index given is greater or equal to 0
# Post:
#       - $a0 contains the integer at the given index if it is valid
#       - $a1 contains 0 on success, or -1 on failure (if the index is invalid)
# -----------------------------------------------------------------------------
LL_INDEX:
        # -- START SOLUTION --
        mv s0, a0
        lw s0, 4(s0)
        li t0, 0
        li t1, 0
        LOOP_I:
        beq s0, t0, END_I
        lw s0, 4(s0)
        addi t1, t1, 1
        j LOOP_I
        END_I:

        bge a1, t1, INVALID_I

        mv s0, a0
        mv t0, a1
        li t1, 0

        INDEX_LOOP:
        beq t0, t1, FOUND_I
        lw t2, 4(s0)
        beq t2, zero, INVALID_I
        mv s0, t2
        addi t1, t1, 1
        j INDEX_LOOP


        #lw s1, 0(s0)
        #beq t0, a1, FOUND_I
        #beq s1, zero, INVALID
        #addi t0, t0, 1
        #lw s1, 4(s0)
        #j INDEX_LOOP
        INVALID_I:
        li a1, -1
        li a0, -1
        j DONE

        FOUND_I:
        li a1, 0
        lw a0, 0(s0)

        DONE:
        # -- END SOLUTION --
        jr ra, 0

# -----------------------------------------------------------------------------
# Return a heap-allocated array of all integers in the given linked list that
# are greater or equal to the given lower bound.
#
# If none of the integers in the linked list are greater or equal to the lower
# bound, return 0 for both the result array and its length.
#
# Example 1:
#       - (argument) Linked list: 1->5->3->7->4->9
#       - (argument) Lower bound: 4
#       - Values in result array on heap: 5, 7, 4, 9
#       - (return value) Array pointer: 0x100040
#       - (return value) Array length: 4
#
# Example 2:
#       - (argument) Linked list: 1->5->3->7->4->9
#       - (argument) Lower bound: 100
#       - (return value) Array pointer: 0
#       - (return value) Array length: 0
#
# Pre:
#       - $a0 contains the address of the head of the linked list
#       - $a1 contains the lower bound of the integers to retrieve
# Post:
#       - $a0 contains the address of the heap-allocated result array
#       - $a1 contains the length of the result array
# -----------------------------------------------------------------------------
LL_GREATER_OR_EQUAL:
        # -- START SOLUTION --
        # -- END SOLUTION --
        jr ra, 0


# -----------------------------------------------------------------------------
# Reverse the given linked list in-place, then return the new head of the
# linked list.
#
# Pre:
#       - $a0 contains the address of the head of the linked list
#       - $a1 contains the address of sentinel value of the linked list
# Post:
#       - $a0 contains the new address of the head of the linked list
# -----------------------------------------------------------------------------
LL_REVERSE:
        # -- START SOLUTION --
        addi sp, sp, -12
        mv t0, sp
        sw s2, 0(t0)
        sw s1, 4(t0)
        sw s0, 8(t0)

        mv s0, a0
        mv s1, a1

        REVERSE_L:
        beq s0, a1, REVERSE_DONE
        lw s2, 4(s0)
        sw s1, 4(s0)
        mv s1, s0
        mv s0, s2
        j REVERSE_L

        REVERSE_DONE:
        addi sp, sp 12
        mv t0, sp
        mv a0, s1
        lw s2, 0(t0)
        lw s1, 4(t0)
        lw s0, 8(t0)

        #mv s0, a0
        #mv s1, a1
        #li t0, 0

        #REVERSE_L:
        #beq s0, s1, REVERSE_END
        #lw t1, 4(s0)
        #sw t0, 4(s0)
        #mv t0, s0
        #mv s0, t1



        #j REVERSE_L



        #REVERSE_END:
        #sw t0, 4(s1)
        #mv a0, t0

        # -- END SOLUTION --
        jr ra, 0







