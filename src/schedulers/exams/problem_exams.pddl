(define (problem dei_exams_problem)
    (:domain dei_exams_domain)
    
    (:objects
        ; Semester 1 Courses
        PLN VD IARP AED CRP SD ES IPRP - course
        
        ; Rooms
        G_5_1 G_5_2 B_1 B_2 A_5_1 C_5_6 C_5_5 C_5_4 C_6_2 E_4_3 D_1_1 D_2_6 D_3_4 - room
        
        ; Time (Exam Epoch Days)
        Day1 Day2 Day3 Day4 Day5 - day
        slot_09_11 slot_11_13 slot_14_16 slot_16_18 slot_18_20 - slot
    )

    (:init
        ; -- Capacity Checks --
        ; ES (300) / SD (298) -> Needs: B_2
        (capacity_ok B_2 ES) (capacity_ok B_2 SD)

        ; IPRP (245) -> Needs: B_1, B_2
        (capacity_ok B_1 IPRP) (capacity_ok B_2 IPRP)

        ; IARP (100) -> Needs: G_5_1, B_1, B_2, C_*
        (capacity_ok G_5_1 IARP) (capacity_ok B_1 IARP) (capacity_ok B_2 IARP) (capacity_ok C_5_6 IARP) (capacity_ok C_5_5 IARP) (capacity_ok C_5_4 IARP) (capacity_ok C_6_2 IARP)

        ; AED (80) / CRP (60) / VD (68) / PLN (53) -> Fits in most except E_4_3 and D_*
        (capacity_ok G_5_1 AED) (capacity_ok G_5_2 AED) (capacity_ok B_1 AED) (capacity_ok B_2 AED) (capacity_ok A_5_1 AED) (capacity_ok C_5_6 AED) (capacity_ok C_5_5 AED) (capacity_ok C_5_4 AED) (capacity_ok C_6_2 AED)
        (capacity_ok G_5_1 CRP) (capacity_ok G_5_2 CRP) (capacity_ok B_1 CRP) (capacity_ok B_2 CRP) (capacity_ok A_5_1 CRP) (capacity_ok C_5_6 CRP) (capacity_ok C_5_5 CRP) (capacity_ok C_5_4 CRP) (capacity_ok C_6_2 CRP)
        (capacity_ok G_5_1 VD) (capacity_ok G_5_2 VD) (capacity_ok B_1 VD) (capacity_ok B_2 VD) (capacity_ok A_5_1 VD) (capacity_ok C_5_6 VD) (capacity_ok C_5_5 VD) (capacity_ok C_5_4 VD) (capacity_ok C_6_2 VD)
        (capacity_ok G_5_1 PLN) (capacity_ok G_5_2 PLN) (capacity_ok B_1 PLN) (capacity_ok B_2 PLN) (capacity_ok A_5_1 PLN) (capacity_ok C_5_6 PLN) (capacity_ok C_5_5 PLN) (capacity_ok C_5_4 PLN) (capacity_ok C_6_2 PLN)
    )

    (:goal (and
        (exam_scheduled PLN)
        (exam_scheduled VD)
        (exam_scheduled IARP)
        (exam_scheduled AED)
        (exam_scheduled CRP)
        (exam_scheduled SD)
        (exam_scheduled ES)
        (exam_scheduled IPRP)
    ))
)