(define (domain dei_exams_domain)
    (:requirements :strips :typing :equality :negative-preconditions)
    
    (:types
        course room day slot - object
    )

    (:predicates
        (capacity_ok ?r - room ?c - course)
        (room_occupied ?r - room ?d - day ?s - slot)
        (exam_scheduled ?c - course)
    )

    (:action schedule_exam
        :parameters (?c - course ?r - room ?d - day ?s - slot)
        :precondition (and
            (not (exam_scheduled ?c))
            (capacity_ok ?r ?c)
            (not (room_occupied ?r ?d ?s))
        )
        :effect (and
            (exam_scheduled ?c)
            (room_occupied ?r ?d ?s)
        )
    )
)