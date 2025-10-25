import sys
import time
import numpy as np
import random
    
from classes import Agent, Composition, ID_START

class Gingerbread(Composition):
    def __init__(self, BPM=60):
        Composition.__init__(self,BPM=BPM)
        self.min=-3
        self.max=8
        self.range=self.max-self.min 
        # your code here
        # Randomized initial conditions
        self.x = random.uniform(-0.5, 0.5)
        self.y = random.uniform(-0.5, 0.5)
        self.amp = random.uniform(0.8, 1.2)

    def map(self, value_in, min_out, max_out):
        value_out = (value_in-self.min)/(self.range)
        value_out = min_out+ value_out * (max_out-min_out)
        return np.clip(value_out, min_out, max_out)

    def next(self):
        x_old = self.x
        self.x = 1-self.y + abs(self.x) + random.uniform(-0.1, 0.1)
        self.y = x_old + random.uniform(-0.05, 0.05)
        self.midinote = int(self.map(self.y,60,84)+ random.uniform(-1, 1))
        self.dur = self.map(self.x,0.1,1)* random.uniform(0.9, 1.1)
        print(self.x, self.y, self.midinote, self.dur)


if __name__=="__main__":
    n_agents=1
    composer=Gingerbread()
    agents=[_ for _ in range(n_agents)]
    agents[0] = Agent(57120, "/note_effect", composer)

    input("Press any key to start \n")
    for agent in agents:
        agent.start()
    try: # USE CTRL+C to exit     
        while True:
            time.sleep(10)
    except:         
        for agent in agents:              
            agent.kill()
            agent.join()
        sys.exit()

# %%