(define (problem dei_exams_problem)
    (:domain dei_exams_domain)
    
    (:objects
        PLN VD IARP AED CRP SD ES IPRP - course
        LIACD_3 LIACD_2 LEI_3 LDM_1 - class_group
        G_5_1 G_5_2 B_1 B_2 A_5_1 C_5_6 C_5_5 C_5_4 C_6_2 E_4_3 D_1_1 D_2_6 D_3_4 - room
        
        ; 31 Days
        Day1 Day2 Day3 Day4 Day5 Day6 Day7 Day8 Day9 Day10
        Day11 Day12 Day13 Day14 Day15 Day16 Day17 Day18 Day19 Day20
        Day21 Day22 Day23 Day24 Day25 Day26 Day27 Day28 Day29 Day30 Day31 - day
        
        slot_09_11 slot_11_13 slot_14_16 slot_16_18 slot_18_20 - slot
        SlotA SlotB - daily_slot
    )

    (:init
        ; Mappings
        (course_belongs_to PLN LIACD_3) (course_belongs_to VD LIACD_3)
        (course_belongs_to IARP LIACD_2) (course_belongs_to AED LIACD_2) (course_belongs_to CRP LIACD_2)
        (course_belongs_to SD LEI_3) (course_belongs_to ES LEI_3)
        (course_belongs_to IPRP LDM_1)

        ; Capacity
        (capacity_ok B_2 ES) (capacity_ok B_2 SD)
        (capacity_ok B_1 IPRP) (capacity_ok B_2 IPRP)
        (capacity_ok G_5_1 IARP) (capacity_ok B_1 IARP) (capacity_ok B_2 IARP) (capacity_ok C_5_6 IARP)
        (capacity_ok G_5_1 AED) (capacity_ok B_1 AED) (capacity_ok A_5_1 AED) (capacity_ok C_5_5 AED)
        (capacity_ok G_5_1 CRP) (capacity_ok B_1 CRP) (capacity_ok A_5_1 CRP) (capacity_ok C_5_5 CRP)
        (capacity_ok G_5_1 VD) (capacity_ok B_1 VD) (capacity_ok A_5_1 VD) (capacity_ok C_5_5 VD)
        (capacity_ok G_5_1 PLN) (capacity_ok B_1 PLN) (capacity_ok A_5_1 PLN) (capacity_ok C_5_5 PLN)

        ; Weekend Definition
        (is_weekend Day6) (is_weekend Day7)
        (is_weekend Day13) (is_weekend Day14)
        (is_weekend Day20) (is_weekend Day21)
        (is_weekend Day27) (is_weekend Day28)

        ; Spacing Logic (Day X is close to X+1..X+5 and simetric below)
        (days_too_close Day1 Day2) (days_too_close Day1 Day3) (days_too_close Day1 Day4) (days_too_close Day1 Day5) (days_too_close Day1 Day6)
        (days_too_close Day2 Day3) (days_too_close Day2 Day4) (days_too_close Day2 Day5) (days_too_close Day2 Day6) (days_too_close Day2 Day7)
        (days_too_close Day3 Day4) (days_too_close Day3 Day5) (days_too_close Day3 Day6) (days_too_close Day3 Day7) (days_too_close Day3 Day8)
        (days_too_close Day4 Day5) (days_too_close Day4 Day6) (days_too_close Day4 Day7) (days_too_close Day4 Day8) (days_too_close Day4 Day9)
        (days_too_close Day5 Day6) (days_too_close Day5 Day7) (days_too_close Day5 Day8) (days_too_close Day5 Day9) (days_too_close Day5 Day10)
        (days_too_close Day6 Day7) (days_too_close Day6 Day8) (days_too_close Day6 Day9) (days_too_close Day6 Day10) (days_too_close Day6 Day11)
        (days_too_close Day7 Day8) (days_too_close Day7 Day9) (days_too_close Day7 Day10) (days_too_close Day7 Day11) (days_too_close Day7 Day12)
        (days_too_close Day8 Day9) (days_too_close Day8 Day10) (days_too_close Day8 Day11) (days_too_close Day8 Day12) (days_too_close Day8 Day13)
        (days_too_close Day9 Day10) (days_too_close Day9 Day11) (days_too_close Day9 Day12) (days_too_close Day9 Day13) (days_too_close Day9 Day14)
        (days_too_close Day10 Day11) (days_too_close Day10 Day12) (days_too_close Day10 Day13) (days_too_close Day10 Day14) (days_too_close Day10 Day15)
        (days_too_close Day11 Day12) (days_too_close Day11 Day13) (days_too_close Day11 Day14) (days_too_close Day11 Day15) (days_too_close Day11 Day16)
        (days_too_close Day12 Day13) (days_too_close Day12 Day14) (days_too_close Day12 Day15) (days_too_close Day12 Day16) (days_too_close Day12 Day17)
        (days_too_close Day13 Day14) (days_too_close Day13 Day15) (days_too_close Day13 Day16) (days_too_close Day13 Day17) (days_too_close Day13 Day18)
        (days_too_close Day14 Day15) (days_too_close Day14 Day16) (days_too_close Day14 Day17) (days_too_close Day14 Day18) (days_too_close Day14 Day19)
        (days_too_close Day15 Day16) (days_too_close Day15 Day17) (days_too_close Day15 Day18) (days_too_close Day15 Day19) (days_too_close Day15 Day20)
        (days_too_close Day16 Day17) (days_too_close Day16 Day18) (days_too_close Day16 Day19) (days_too_close Day16 Day20) (days_too_close Day16 Day21)
        (days_too_close Day17 Day18) (days_too_close Day17 Day19) (days_too_close Day17 Day20) (days_too_close Day17 Day21) (days_too_close Day17 Day22)
        (days_too_close Day18 Day19) (days_too_close Day18 Day20) (days_too_close Day18 Day21) (days_too_close Day18 Day22) (days_too_close Day18 Day23)
        (days_too_close Day19 Day20) (days_too_close Day19 Day21) (days_too_close Day19 Day22) (days_too_close Day19 Day23) (days_too_close Day19 Day24)
        (days_too_close Day20 Day21) (days_too_close Day20 Day22) (days_too_close Day20 Day23) (days_too_close Day20 Day24) (days_too_close Day20 Day25)
        (days_too_close Day21 Day22) (days_too_close Day21 Day23) (days_too_close Day21 Day24) (days_too_close Day21 Day25) (days_too_close Day21 Day26)
        (days_too_close Day22 Day23) (days_too_close Day22 Day24) (days_too_close Day22 Day25) (days_too_close Day22 Day26) (days_too_close Day22 Day27)
        (days_too_close Day23 Day24) (days_too_close Day23 Day25) (days_too_close Day23 Day26) (days_too_close Day23 Day27) (days_too_close Day23 Day28)
        (days_too_close Day24 Day25) (days_too_close Day24 Day26) (days_too_close Day24 Day27) (days_too_close Day24 Day28) (days_too_close Day24 Day29)
        (days_too_close Day25 Day26) (days_too_close Day25 Day27) (days_too_close Day25 Day28) (days_too_close Day25 Day29) (days_too_close Day25 Day30)
        (days_too_close Day26 Day27) (days_too_close Day26 Day28) (days_too_close Day26 Day29) (days_too_close Day26 Day30) (days_too_close Day26 Day31)
        (days_too_close Day27 Day28) (days_too_close Day27 Day29) (days_too_close Day27 Day30) (days_too_close Day27 Day31)
        (days_too_close Day28 Day29) (days_too_close Day28 Day30) (days_too_close Day28 Day31)
        (days_too_close Day29 Day30) (days_too_close Day29 Day31)
        (days_too_close Day30 Day31)
    )

    (:goal (and
        (exam_scheduled PLN) (exam_scheduled VD)
        (exam_scheduled IARP) (exam_scheduled AED) (exam_scheduled CRP)
        (exam_scheduled SD) (exam_scheduled ES)
        (exam_scheduled IPRP)
    ))
)