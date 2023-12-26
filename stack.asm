.data
.text

.globl PROC_GREATER_DIGIT_SUM
.globl PROC_ADD_DIGITS

# -----------------------------------------------------------------------------
# Given two positive integers, return the integer with the greater digit sum.
# The digit sum of an integer is the sum of its digits, ie.
# digit_sum(432) == 9
# If they have equal digit sums, return -1
#
# Pre:
#       - $a0 contains the first positive integer
#       - $a1 contains the second positive integer
# Post:
#       - $a0 contains the integer with the greater digit sum
# -----------------------------------------------------------------------------
PROC_GREATER_DIGIT_SUM:
        # -- START EDITING HERE --
        #sub, sp, sp, 32
        #mv, t3, sp
        #sw s0, 20(t3)
        #sw s1, 24(t3)
        #sw s2, 28(t3)
        addi sp, sp, -32
        mv t3, sp
        sw s0, -20(t3)
        sw s1, -24(t3)
	sw ra, -28(t3)
	#sw s0, -24(sp)
	#sw s1, -20(sp)
        # -- END EDITING HERE --

        addi    s0, a0, 0               # Save the first integer
        addi    s1, a1, 0               # Save the second integer

        # Sum digits of first integer and save to t0
        addi    a0, s0, 0
        jal     ra, PROC_ADD_DIGITS
        addi    t0, a0, 0

        # -- START EDITING HERE --
        #lw t0, 16(t3)
        sw t0, -16(t3)
        # -- END EDITING HERE --

        # Sum digits of second integer and save to t1
        addi    a0, s1, 0
        jal     ra, PROC_ADD_DIGITS
        addi    t1, a0, 0

        # -- START EDITING HERE --
        
	lw t0, -16(t3)
	sw t1, -12(t3)
        #lw t0, 16(t3)
        # -- END EDITING HERE --

        # Assume the first integer has the greater digit sum
        addi    a0, s0, 0

        # Check our assumption
        beq     t0, t1, PROC_GDS_EQUAL
        blt     t0, t1, PROC_GDS_SECOND_INTEGER_GREATER
        j       PROC_GDS_EXIT

        PROC_GDS_EQUAL:
                li      a0, -1
                j       PROC_GDS_EXIT

        PROC_GDS_SECOND_INTEGER_GREATER:
                addi    a0, s1, 0

        PROC_GDS_EXIT:

        # -- START EDITING HERE --
        
	lw s0, -20(t3)
	lw s1, -24(t3)
	lw ra, -28(t3)
	sw a0, -8(t3)
	#sw a0, 8(t3)
	#add a0, -8(sp), zero
        # -- END EDITING HERE --

        jr      ra, 0

# -----------------------------------------------------------------------------
# Given a positive integer, return the sum of its digits.
#
# Pre:
#       - $a0 contains the positive integer
# Post:
#       - $a0 contains the integer's digit sum
# -----------------------------------------------------------------------------
PROC_ADD_DIGITS:
        li      t0, 0           # Accumulator
        li      t1, 10          # Constant 10 for divrem
        li      t2, 0           # Temporary to store rem result

        PROC_AD_LOOP:
                rem     t2, a0, t1
                add     t0, t0, t2
                ble     a0, t1, PROC_AD_EXIT
                div     a0, a0, t1
                j       PROC_AD_LOOP

        PROC_AD_EXIT:
                addi    a0, t0, 0
                jr      ra, 0


