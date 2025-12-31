(define (domain dei_exams_domain)
    (:requirements :strips :typing :equality :negative-preconditions :adl)
    
    (:types
        course room day slot class_group daily_slot - object
    )

    (:predicates
        (capacity_ok ?r - room ?c - course)
        (course_belongs_to ?c - course ?cg - class_group)
        (days_too_close ?d1 - day ?d2 - day)
        (is_weekend ?d - day)
        (room_occupied ?r - room ?d - day ?s - slot)
        (exam_scheduled ?c - course)
        (class_blocked_on_day ?cg - class_group ?d - day)
        (day_slot_used ?d - day ?ds - daily_slot)
    )

    (:action schedule_exam
        :parameters (?c - course ?cg - class_group ?r - room ?d - day ?s - slot ?ds - daily_slot)
        :precondition (and
            (not (exam_scheduled ?c))
            (course_belongs_to ?c ?cg)
            (capacity_ok ?r ?c)
            (not (room_occupied ?r ?d ?s))
            (not (is_weekend ?d))
            (not (class_blocked_on_day ?cg ?d))
            (not (day_slot_used ?d ?ds))
        )
        :effect (and
            (exam_scheduled ?c)
            (room_occupied ?r ?d ?s)
            (day_slot_used ?d ?ds)
            (class_blocked_on_day ?cg ?d)
            
            ; Checks the static list in BOTH directions (Simetric analysis)
            ; If Day 29 is 'too close' to Day 30, scheduling Day 30 will block Day 29.
            (forall (?neighbor - day)
                (when (or (days_too_close ?d ?neighbor) (days_too_close ?neighbor ?d))
                        (class_blocked_on_day ?cg ?neighbor))
            )
        )
    )
)