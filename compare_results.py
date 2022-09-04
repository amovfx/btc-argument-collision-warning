import sys
master_result_file = sys.argv[1]
branch_result_file = sys.argv[2]


master_data = []
with open(master_result_file) as data:
    master_data = data.readlines()

branch_data = [] 
with open(branch_result_file) as data:
    branch_data = data.readlines()
    
    
count = 0
for line in zip(master_data, branch_data):
    if line[0] != line[1]:
        if (line[0].strip() + " Too many network flags being set in the commandline.") == line[1].strip():
            count += 1
        else:
            print(f"Error: {line[0]} {line[1]}")
        
    else:
        count += 1
        
if count == len(master_data):
    print("All tests passed")
        