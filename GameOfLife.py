import numpy as np
import matplotlib.pyplot as plt
import time
import matplotlib.animation as animation
import argparse
#from gol_structures import *

parser = argparse.ArgumentParser(description="Game of Life")
                                                    #max size of signed int
parser.add_argument("--seed", default=np.random.randint(0, 2147483647), type=int, help="Seed for random generation (random by default)")
parser.add_argument("--empty_probability", default=0.8, type=float, help="Fraction of squares left empty (0.8 by default)")
parser.add_argument("--rows", default=50, type=int, help="Number of rows in grid")
parser.add_argument("--cols", default=50, type=int, help="Number of columns in grid")
parser.add_argument("--steps", default=500, type=int, help="Number of steps the algorithm runs")
parser.add_argument("--gif", default=1, type=int, help="Should a GIF be generated (default=1)")

args = parser.parse_args()

np.random.seed(args.seed)

progression = []
rows = args.rows
cols = args.cols

size = (rows,cols)

prob_0 = args.empty_probability              

# Random initialization of the 2D environment
x = np.random.choice([0, 1], size=size, p=[prob_0, 1-prob_0])
#x = np.zeros(size)
#x = add_glider_gun(x,5,5)
#x = add_eater(x,20,40)

prev = x.copy()
progression.append(prev)

steps = args.steps

start_time = time.time()
print("Algorithm starting")

for t in range(steps):
    for r in range(rows):
        for c in range(cols):
            total = 0
            # Count how many are in its neighborhood
            for rn in [i%rows for i in range(r-1, r+2)]:
                for cn in [i%cols for i in range(c-1, c+2)]:
                    total += prev[rn, cn]
            # Subtract myself
            total -= prev[r,c]
            if (prev[r,c] == 0 and total == 3):
                x[r,c] = 1
            elif (prev[r,c] == 1 and total != 2 and total != 3):
                x[r,c] = 0

    # Keep track of the progression for animation        
    prev = x.copy()
    progression.append(prev)

elapsed_time = round((time.time() - start_time), 4)
print("Elapsed time:", elapsed_time, "seconds")

def update(i):
    mat.set_data(progression[i])

if (args.gif == 1):
    print("Making GIF now")
    
    fig, ax = plt.subplots()
    mat = ax.matshow(progression[0], cmap='binary')
    ani = animation.FuncAnimation(fig, update, interval=50, frames=steps, repeat=False)
    ani.save(f"Seed{args.seed}E{args.empty_probability}R{args.rows}C{args.cols}S{args.steps}.gif")
    plt.show()
