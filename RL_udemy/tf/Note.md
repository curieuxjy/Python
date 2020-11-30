## Notes

* Prediction Pseudocode

```python
Given: pi, N
V = {}
all_returns = {} #default value = [], key = state, value = list of returns
do N times:
    states, returns = play_one_episode(pi)
    for s, g in zip(states, returns):
        all_returns[s].append(g)
        V(s) = np.mean(all_returns[s])
    return V
```

* Control Pseudocode

```python 
Given: N
    Init: Q = random, pi = random, all_returns ={}
    do N times:
        states, sctions, returns = play_one_episode(pi) #using epsilon-greedy
        for s, a, g, in zip(states, actions, returns):
            all_returns[s, a].append(g)
            Q[s, a] = np.mean(all_returns[s, a])
        for s in state_space:
            pi[s] = np.argmax(Q[s, :])
```

* exponentially smoothed mean