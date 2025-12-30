(define (problem dei_lectures_problem)
    (:domain dei_lectures_domain)
    
    (:objects 
        ; Semester 2 Courses
        PA OC SGD PGI FPS EA CM AMII EST - course
        
        ; Rooms
        G_5_1 G_5_2 B_1 B_2 A_5_1 C_5_6 C_5_5 C_5_4 C_6_2 E_4_3 D_1_1 D_2_6 D_3_4 - room
        
        ; Time
        Mon Tue Wed Thu Fri - day
        slot_09_11 slot_11_13 slot_14_16 slot_16_18 slot_18_20 - slot
    )

    (:init
        ; -- Capacity Checks (True if Room Cap >= Course Cap) --
        
        ; PA (123) -> Needs: B_1, B_2, C_5_6, C_5_5, C_5_4, C_6_2
        (capacity_ok B_1 PA) (capacity_ok B_2 PA) (capacity_ok C_5_6 PA) (capacity_ok C_5_5 PA) (capacity_ok C_5_4 PA) (capacity_ok C_6_2 PA)

        ; OC (167) / CM (167) / EA (171) -> Needs: B_1, B_2
        (capacity_ok B_1 OC) (capacity_ok B_2 OC)
        (capacity_ok B_1 CM) (capacity_ok B_2 CM)
        (capacity_ok B_1 EA) (capacity_ok B_2 EA)

        ; SGD (93) / AMII (95) / EST (95) -> Needs: G_5_1, B_1, B_2, C_* (160s)
        (capacity_ok G_5_1 SGD) (capacity_ok B_1 SGD) (capacity_ok B_2 SGD) (capacity_ok C_5_6 SGD) (capacity_ok C_5_5 SGD) (capacity_ok C_5_4 SGD) (capacity_ok C_6_2 SGD)
        (capacity_ok G_5_1 AMII) (capacity_ok B_1 AMII) (capacity_ok B_2 AMII) (capacity_ok C_5_6 AMII) (capacity_ok C_5_5 AMII) (capacity_ok C_5_4 AMII) (capacity_ok C_6_2 AMII)
        (capacity_ok G_5_1 EST) (capacity_ok B_1 EST) (capacity_ok B_2 EST) (capacity_ok C_5_6 EST) (capacity_ok C_5_5 EST) (capacity_ok C_5_4 EST) (capacity_ok C_6_2 EST)

        ; PGI (45) -> Fits in almost all except D rooms
        (capacity_ok G_5_1 PGI) (capacity_ok G_5_2 PGI) (capacity_ok B_1 PGI) (capacity_ok B_2 PGI) (capacity_ok A_5_1 PGI) (capacity_ok C_5_6 PGI) (capacity_ok C_5_5 PGI) (capacity_ok C_5_4 PGI) (capacity_ok C_6_2 PGI) (capacity_ok E_4_3 PGI)

        ; FPS (135) -> Needs: B_1, B_2, C_* (160s)
        (capacity_ok B_1 FPS) (capacity_ok B_2 FPS) (capacity_ok C_5_6 FPS) (capacity_ok C_5_5 FPS) (capacity_ok C_5_4 FPS) (capacity_ok C_6_2 FPS)
    )

    (:goal (and
        (course_scheduled_2 PA)
        (course_scheduled_2 OC)
        (course_scheduled_2 SGD)
        (course_scheduled_2 PGI)
        (course_scheduled_2 FPS)
        (course_scheduled_2 EA)
        (course_scheduled_2 CM)
        (course_scheduled_2 AMII)
        (course_scheduled_2 EST)
    ))
)