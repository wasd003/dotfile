import matplotlib.pyplot as plt

# Data Preparation
xlabels = ['C', 'C++', 'Java', 'Python', 'PHP']
data = [23,17,35,29,12]
data_std = [12, 34, 45, 42, 35]

fig, ax = plt.subplots()

# Set right & top line invisible
ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)

p = ax.bar(xlabels, data, yerr=data_std,
        color='#82CAFF', edgecolor='none')

# Draw Label
ax.bar_label(p, label_type='edge', fontsize=14)
ax.set_ylabel("ylabel", fontsize=16)
ax.set_xlabel("xlabel", fontsize=16)
fig.tight_layout()
plt.savefig("test.png")
