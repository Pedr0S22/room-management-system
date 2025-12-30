import os
import pathlib

from agents.agent_room_booking import BookingAgent
from owlready2 import *
from dei_department import *

BASE_PATH = pathlib.Path(__file__).parent.resolve()
ONTOLOGY_FILE = str(BASE_PATH / "dei_room_management.owl")

owlready2.JAVA_EXE = "java"

if os.path.exists(ONTOLOGY_FILE):
    onto = get_ontology(ONTOLOGY_FILE).load()
else:
    onto = get_ontology(ONTOLOGY_FILE)

agent = BookingAgent(onto)

def populate_system():
    print("=== Initializing DEI Data Population ===\n")

    # 1. Add Courses (Name, Year, Student Capacity)

    # LIACD
    print("Adding Courses...")
    agent.add_course("PLN", 3, 1, 53)
    agent.add_course("VD", 3, 1, 68)
    agent.add_course("IARP", 2, 1, 100)
    agent.add_course("AED", 2, 1, 80)
    agent.add_course("CRP", 2, 1, 60)

    agent.add_course("PA", 3, 2, 123)
    agent.add_course("OC", 2, 2, 167)
    agent.add_course("SGD", 2, 2, 93)
    agent.add_course("PGI", 2, 2, 45)
    agent.add_course("FPS", 2, 2, 135)

    # LEI (+ LIACD E LDM)

    agent.add_course("SD", 3, 1, 298)
    agent.add_course("EA", 3, 2, 171)
    agent.add_course("ES", 3, 1, 300)

    agent.add_course("AMII", 1, 2, 95)
    agent.add_course("EST", 1, 2, 95)

    # LDM

    agent.add_course("IPRP", 1, 1, 245)
    agent.add_course("CM", 3, 2, 167)

    # 2. Add Academic Classes (Name, Year)
    print("Adding Academic Classes...")
    agent.add_academic_class("LEI", 3)
    #add_academic_class("LEI", 2)
    agent.add_academic_class("LEI", 1)

    agent.add_academic_class("LIACD", 3)
    agent.add_academic_class("LIACD", 2)
    #add_academic_class("LIACD", 1)

    agent.add_academic_class("LDM", 3)
    #add_academic_class("LDM", 2)
    agent.add_academic_class("LDM", 1)

    
    # 3. Add Rooms (Name, Capacity, Has Projector)
    print("Adding Rooms...")
    agent.add_room("G.5.1", 120, True)
    agent.add_room("G.5.2", 90, False)

    agent.add_room("B.1", 280, True)
    agent.add_room("B.2", 320, True)

    agent.add_room("A.5.1", 90, True)
    agent.add_room("C.5.6", 160, False)
    agent.add_room("C.5.5", 160, True)
    agent.add_room("C.5.4", 160, True)
    agent.add_room("C.6.2", 150, True)
    agent.add_room("E.4.3", 50, True)

    agent.add_room("D.1.1", 10, True)
    agent.add_room("D.2.6", 15, False)
    agent.add_room("D.3.4", 12, False)

    # 4. Add Teachers (Name, ID > 99, List of Course Names)
    print("Adding Teachers...")
    agent.add_teacher("Pedro Martins", 101, ["CRP"])
    agent.add_teacher("Ricardo Pereira", 102, ["CRP","IARP"])
    agent.add_teacher("Ana Sousa", 103, ["SD", "ES"])         # Teaches LEI courses
    agent.add_teacher("Bruno Costa", 104, ["IPRP"])           # Teaches LDM 1st year
    agent.add_teacher("Carla Dias", 105, ["PLN", "VD", "PA"]) # Teaches LIACD 3rd year
    agent.add_teacher("Diogo Silva", 106, ["AED", "OC"])      # Teaches LIACD 2nd year
    agent.add_teacher("Elena Rossi", 107, ["CM", "EA"])       # Teaches LDM/LEI mixed
    agent.add_teacher("Tiago Baptista", 108, ["SGD", "PGI"])
    agent.add_teacher("Joana Dias", 109, ["FPS"])
    agent.add_teacher("Carlos Santos", 110, ["AMII", "EST"])

    # 5. Add Students (Name, ID, Class Name, Year, List of Course Names)
    print("Adding Students...")
    agent.add_student("Joao Silva", 2021001, "LEI", 3, ["CRP", "IARP"])
    agent.add_student("Maria Santos", 2021002, "LEI", 3, ["CRP"])

    # LEI Year 3 Student
    agent.add_student("Rui Almeida", 2021111, "LEI", 3, ["SD", "ES", "EA"])
    
    # LIACD Year 3 Student
    agent.add_student("Sofia Marques", 2021222, "LIACD", 3, ["PLN", "VD", "PA"])
    
    # LIACD Year 2 Student
    agent.add_student("Miguel Torres", 2022333, "LIACD", 2, ["IARP", "AED", "OC", "CRP"])
    
    # LDM Year 1 Student
    agent.add_student("Lara Croft", 2023444, "LDM", 1, ["IPRP"])
    
    # LDM Year 3 Student
    agent.add_student("Nuno Gomes", 2021555, "LDM", 3, ["CM"])

    # LEI Year 1 (Previously empty)
    agent.add_student("Andreia Nunes", 2023001, "LEI", 1, ["AMII", "EST"])
    agent.add_student("Bernardo Lima", 2023002, "LEI", 1, ["AMII"])
    agent.add_student("Carlos Andrade", 2023003, "LEI", 1, ["EST", "AMII"])

    # LIACD Year 2 (Populating the Game/Physics courses)
    agent.add_student("Catarina Oliveira", 2022005, "LIACD", 2, ["SGD", "PGI", "FPS"])
    agent.add_student("Daniel Sousa", 2022006, "LIACD", 2, ["SGD", "FPS", "AED"])
    
    # LDM Year 1 (Adding peers for Lara)
    agent.add_student("Eduardo Martins", 2023005, "LDM", 1, ["IPRP", "AMII"]) # AMII often shared
    agent.add_student("Filipa Rocha", 2023006, "LDM", 1, ["IPRP"])

    # LDM Year 3 (Adding peers for Nuno)
    agent.add_student("Goncalo Reis", 2021009, "LDM", 3, ["CM"])
    agent.add_student("Helena Viana", 2021010, "LDM", 3, ["CM", "EA"])

    # 6. Finalize
    print("\nData population complete.")
    print("Running reasoner to verify inferred classes...")
    save()

if __name__ == "__main__":
    # Ensure the ontology is loaded
    if not onto:
        print("Error: Could not load ontology.")
    else:
        populate_system()
        print("\nAll data has been saved to dei_room_management.owl")