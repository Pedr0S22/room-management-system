(define (problem dei_lectures_problem)
    (:domain dei_lectures_domain)
    
    (:objects
        ; courses
        PA OC SGD PGI FPS EA CM AMII EST WEB IA SO RC TC CG NET DB ML CV NLP DIST - course
        
        ; rooms
        G_5_1 G_5_2 B_1 B_2 A_5_1 C_5_6 C_5_5 C_5_4 E_4_3 D_1_1 D_2_6 D_3_4 - room
        
        ; days
        Mon Tue Wed Thu Fri - day

        ; time slots
        slot_09_11 slot_11_13 slot_14_16 slot_16_18 slot_18_20 - slot
    )

    (:init
        ; Capacity Checks
        
        ; TIER 1: MASSIVE (Only B.1, B.2, C.5.6)
        (capacity_ok B_1 ML)
        (capacity_ok B_2 CV)
        (capacity_ok B_1 NLP) (capacity_ok B_2 NLP) (capacity_ok C_5_6 NLP)
        (capacity_ok B_1 DIST) (capacity_ok B_2 DIST) (capacity_ok C_5_6 DIST)

        ; TIER 2: LARGE (Need B-block or C-block)
        (capacity_ok B_1 PA) (capacity_ok B_2 PA) (capacity_ok C_5_6 PA) (capacity_ok C_5_5 PA)
        (capacity_ok B_1 OC) (capacity_ok B_2 OC) (capacity_ok C_5_6 OC)
        (capacity_ok B_1 EA) (capacity_ok B_2 EA) (capacity_ok C_5_6 EA)
        (capacity_ok B_1 CM) (capacity_ok B_2 CM) (capacity_ok C_5_6 CM)
        (capacity_ok B_1 NET) (capacity_ok B_2 NET) (capacity_ok C_5_6 NET)
        (capacity_ok B_1 DB) (capacity_ok B_2 DB) (capacity_ok C_5_6 DB)

        ; TIER 3: MEDIUM (Fit in G_5_1, A_5_1, etc.)
        (capacity_ok G_5_1 SGD) (capacity_ok B_1 SGD) (capacity_ok B_2 SGD) (capacity_ok C_5_6 SGD) (capacity_ok C_5_5 SGD)
        (capacity_ok G_5_1 AMII) (capacity_ok B_1 AMII) (capacity_ok B_2 AMII) (capacity_ok C_5_6 AMII) (capacity_ok C_5_5 AMII)
        (capacity_ok G_5_1 EST) (capacity_ok B_1 EST) (capacity_ok B_2 EST) (capacity_ok C_5_6 EST) (capacity_ok C_5_5 EST)
        (capacity_ok G_5_1 FPS) (capacity_ok B_1 FPS) (capacity_ok C_5_6 FPS)
        (capacity_ok G_5_1 CG) (capacity_ok B_1 CG) (capacity_ok A_5_1 CG) (capacity_ok C_5_5 CG)
        (capacity_ok G_5_1 TC) (capacity_ok B_1 TC) (capacity_ok A_5_1 TC) (capacity_ok C_5_5 TC)

        ; TIER 4: SMALL (Fit almost anywhere)
        (capacity_ok G_5_1 PGI) (capacity_ok A_5_1 PGI) (capacity_ok E_4_3 PGI) (capacity_ok B_1 PGI) (capacity_ok B_2 PGI)
        (capacity_ok G_5_1 WEB) (capacity_ok B_1 WEB) (capacity_ok B_2 WEB) (capacity_ok C_5_5 WEB)
        (capacity_ok B_1 IA) (capacity_ok B_2 IA) (capacity_ok C_5_6 IA)
        (capacity_ok G_5_1 SO) (capacity_ok B_1 SO) (capacity_ok C_5_5 SO)
        (capacity_ok G_5_1 RC) (capacity_ok B_1 RC) (capacity_ok C_5_4 RC)
    )

    (:goal (and
        ; Every course must be scheduled TWICE
        (course_scheduled_2 PA) (course_scheduled_2 OC)
        (course_scheduled_2 SGD) (course_scheduled_2 PGI)
        (course_scheduled_2 FPS) (course_scheduled_2 EA)
        (course_scheduled_2 CM) (course_scheduled_2 AMII)
        (course_scheduled_2 EST) (course_scheduled_2 WEB)
        (course_scheduled_2 IA) (course_scheduled_2 SO)
        (course_scheduled_2 RC) (course_scheduled_2 TC)
        (course_scheduled_2 CG) (course_scheduled_2 NET)
        (course_scheduled_2 ML) (course_scheduled_2 CV)
        (course_scheduled_2 NLP) (course_scheduled_2 DIST)
        (course_scheduled_2 DB)
    ))
)