import os
import pathlib
from unified_planning.shortcuts import *
from unified_planning.io import PDDLReader

BASE_PATH = pathlib.Path(__file__).parent.resolve()
get_environment().credits_stream = None

def run_scheduler(mode, algo_choice):
    print(f"\n[Planning {mode.capitalize()}]\n")
    
    if mode == "lectures":
        domain_file = str(BASE_PATH / mode / "domain_lectures.pddl")
        problem_file = str(BASE_PATH / mode / "problem_lectures.pddl")
    elif mode == "exams":
        domain_file = str(BASE_PATH / mode / "domain_exams.pddl")
        problem_file = str(BASE_PATH / mode / "problem_exams.pddl")
    else:
        print(f"Interface Error: {mode} does not exist.")
        return
    
    # Check if files exist
    if not os.path.exists(domain_file) or not os.path.exists(problem_file):
        print(f"Error: {domain_file} or {problem_file} not found.")
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
                print("=" * 50)
                schedule = []
                for a in result.plan.actions:
                    p = a.actual_parameters
                    item = {
                        "course": str(p[0]),
                        "room": str(p[1]),
                        "day": str(p[2]),
                        "slot": str(p[3])
                    }
                    if mode == "exams":
                        item["class"] = str(p[1])
                        item["room"] = str(p[2])
                        item["day"] = str(p[3])
                        item["slot"] = str(p[4])
                        
                    schedule.append(item)
                
                # Sorter helper
                def sort_key(x):
                    d_val = x['day'].lower()
                    
                    if d_val.startswith("day"):
                        try:
                            return (int(d_val[3:]), x['slot'])
                        except ValueError:
                            return (999, x['slot'])
                    else:
                        days_map = {"mon":1, "tue":2, "wed":3, "thu":4, "fri":5}
                        return (days_map.get(d_val, 99), x['slot'])

                schedule.sort(key=sort_key)
                
                if mode == "exams":
                    print(f"{'DAY':<6} | {'SLOT':<11} | {'CLASS':<8} | {'COURSE':<7} | {'ROOM'}")
                else:
                    print(f"{'DAY':<6} | {'SLOT':<11} | {'COURSE':<7} | {'ROOM'}")
                print("-" * 50)
                
                for item in schedule:
                    if mode == "exams":
                        print(f"{item['day']:<6} | {item['slot']:<11} | {item['class']:<8} | {item['course']:<7} | {item['room']}")
                    else:
                        print(f"{item['day']:<6} | {item['slot']:<11} | {item['course']:<7} | {item['room']}")
                print("=" * 50)
            else:
                print(f"No plan found. Status: {result.status.name}")
    except Exception as e:
        print(f"Error running planner: {e}")