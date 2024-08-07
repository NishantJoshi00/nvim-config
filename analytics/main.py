import pandas as pd

filename = input().strip()

primitive = pd.read_csv(filename)

## The CSV imported as the following:
# clock, action
# We need to find the time spent on each action

primitive['time'] = primitive['clock'].diff().fillna(0)

# sort the values by time
primitive = primitive.sort_values(by='time', ascending=False)

# remove clock column
primitive = primitive.drop(columns=['clock'])

## Print the worst action

for i in range(10):
    print(primitive.iloc[i]['action'], primitive.iloc[i]['time'])


