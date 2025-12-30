import sys
import os
import pathlib
from unified_planning.shortcuts import *
from unified_planning.io import PDDLReader

BASE_PATH = pathlib.Path(__file__).parent.resolve()

def run_scheduler(mode, algo_choice):
    print(f"\n[Planning {mode.capitalize()}]\n")
    
    if mode == "lectures":
        domain_file = str(BASE_PATH / "domain_lectures.pddl")
        problem_file = str(BASE_PATH / "problem_lectures.pddl")
    else:
        domain_file = str(BASE_PATH / "domain_exams.pddl")
        problem_file = str(BASE_PATH / "problem_exams.pddl")
    
    # Check if files exist
    if not os.path.exists(domain_file) or not os.path.exists(problem_file):
        print(f"Error: Could not find {domain_file} or {problem_file}.")
        print("Please ensure you have created the 4 static PDDL files.")
        return

    # Algorithm Selection
    if algo_choice == '1':
        planner_name = "fast-downward"
        print(f"Solving using {planner_name} (Satisficing)...")
    else:
        planner_name = "fast-downward-opt"
        print(f"Solving using {planner_name} (Optimal)...")
    
    try:
        # Load PDDL
        reader = PDDLReader()
        problem = reader.parse_problem(domain_file, problem_file)
        
        with OneshotPlanner(name=planner_name) as planner:
            result = planner.solve(problem)
            
            if result.status.name in ['SOLVED_SATISFICING', 'SOLVED_OPTIMALLY']:
                print("\nPlan found!")
                print("=" * 60)
                schedule = []
                for a in result.plan.actions:
                    p = a.actual_parameters
                    # Format: Course | Room | Day | Slot
                    schedule.append({
                        "course": str(p[0]),
                        "room": str(p[1]),
                        "day": str(p[2]),
                        "slot": str(p[3])
                    })
                
                # Sort: Day -> Slot -> Room
                schedule.sort(key=lambda x: (x['day'], x['slot'], x['room']))
                
                print(f"{'DAY':<5} | {'SLOT':<7} | {'COURSE':<6} | {'ROOM'}")
                print("-" * 60)
                for item in schedule:
                    print(f"{item['day']:<5} | {item['slot']:<7} | {item['course']:<6} | {item['room']}")
                print("=" * 60)
            else:
                print(f"No plan found. Status: {result.status.name}")
    except Exception as e:
        print(f"Error running planner: {e}")