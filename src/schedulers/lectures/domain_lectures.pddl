(define (domain dei_lectures_domain)
    (:requirements :strips :typing :equality :negative-preconditions)
    
    (:types course room day slot - object)

    (:predicates
        (capacity_ok ?r - room ?c - course)
        (room_occupied ?r - room ?d - day ?s - slot)
        (course_scheduled_1 ?c - course)
        (course_scheduled_2 ?c - course)
    )

    (:action schedule_class_1
        :parameters (?c - course ?r - room ?d - day ?s - slot)
        :precondition (and
            (not (course_scheduled_1 ?c))
            (capacity_ok ?r ?c)
            (not (room_occupied ?r ?d ?s))
        )
        :effect (and
            (course_scheduled_1 ?c)
            (room_occupied ?r ?d ?s)
        )
    )

    (:action schedule_class_2
        :parameters (?c - course ?r - room ?d - day ?s - slot)
        :precondition (and
            (course_scheduled_1 ?c)
            (not (course_scheduled_2 ?c))
            (capacity_ok ?r ?c)
            (not (room_occupied ?r ?d ?s))
        )
        :effect (and
            (course_scheduled_2 ?c)
            (room_occupied ?r ?d ?s)
        )
    )
)