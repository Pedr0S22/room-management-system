import os
import pathlib
from owlready2 import *
from dei_department import *

BASE_PATH = pathlib.Path(__file__).parent.resolve()
ONTOLOGY_FILE = str(BASE_PATH / "dei_room_management.owl")

owlready2.JAVA_EXE = "java"

if os.path.exists(ONTOLOGY_FILE):
    onto = get_ontology(ONTOLOGY_FILE).load()
else:
    onto = get_ontology(ONTOLOGY_FILE)

def populate_system():
    print("=== Initializing DEI Data Population ===\n")

    # 1. Add Courses (Name, Year, Student Capacity)

    # LIACD
    print("Adding Courses...")
    add_course("PLN", 3, 1, 53)
    add_course("VD", 3, 1, 68)
    add_course("IARP", 2, 1, 100)
    add_course("AED", 2, 1, 80)
    add_course("CRP", 2, 1, 60)

    add_course("PA", 3, 2, 123)
    add_course("OC", 2, 2, 167)

    # LEI (+ LIACD E LDM)

    add_course("SD", 3, 1, 298)
    add_course("EA", 3, 2, 171)
    add_course("ES", 3, 1, 300)

    # LDM

    add_course("IPRP", 1, 1, 245)
    add_course("CM", 3, 2, 167)

    # 2. Add Academic Classes (Name, Year)
    print("Adding Academic Classes...")
    add_academic_class("LEI", 3)
    #add_academic_class("LEI", 2)
    #add_academic_class("LEI", 1)

    add_academic_class("LIACD", 3)
    add_academic_class("LIACD", 2)
    #add_academic_class("LIACD", 1)

    add_academic_class("LDM", 3)
    #add_academic_class("LDM", 2)
    add_academic_class("LDM", 1)

    
    # 3. Add Rooms (Name, Capacity, Has Projector)
    print("Adding Rooms...")
    add_room("G.5.1", 120, True)
    add_room("G.5.2", 90, False)

    add_room("B.1", 280, True)
    add_room("B.2", 320, True)

    add_room("A.5.1", 90, True)
    add_room("C.5.6", 160, False)
    add_room("C.5.5", 160, True)
    add_room("C.5.4", 160, True)
    add_room("C.6.2", 150, True)
    add_room("E.4.3", 50, True)

    add_room("D.1.1", 10, True)
    add_room("D.2.6", 15, False)
    add_room("D.3.4", 12, False)

    # 4. Add Teachers (Name, ID > 99, List of Course Names)
    print("Adding Teachers...")
    add_teacher("Pedro Martins", 101, ["CRP"])
    add_teacher("Ricardo Pereira", 102, ["CRP","IARP"])
    add_teacher("Ana Sousa", 103, ["SD", "ES"])         # Teaches LEI courses
    add_teacher("Bruno Costa", 104, ["IPRP"])           # Teaches LDM 1st year
    add_teacher("Carla Dias", 105, ["PLN", "VD", "PA"]) # Teaches LIACD 3rd year
    add_teacher("Diogo Silva", 106, ["AED", "OC"])      # Teaches LIACD 2nd year
    add_teacher("Elena Rossi", 107, ["CM", "EA"])       # Teaches LDM/LEI mixed

    # 5. Add Students (Name, ID, Class Name, Year, List of Course Names)
    print("Adding Students...")
    add_student("Joao Silva", 2021001, "LEI", 3, ["CRP", "IARP"])
    add_student("Maria Santos", 2021002, "LEI", 3, ["CRP"])

    # LEI Year 3 Student
    add_student("Rui Almeida", 2021111, "LEI", 3, ["SD", "ES", "EA"])
    
    # LIACD Year 3 Student
    add_student("Sofia Marques", 2021222, "LIACD", 3, ["PLN", "VD", "PA"])
    
    # LIACD Year 2 Student
    add_student("Miguel Torres", 2022333, "LIACD", 2, ["IARP", "AED", "OC", "CRP"])
    
    # LDM Year 1 Student
    add_student("Lara Croft", 2023444, "LDM", 1, ["IPRP"])
    
    # LDM Year 3 Student
    add_student("Nuno Gomes", 2021555, "LDM", 3, ["CM"])

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