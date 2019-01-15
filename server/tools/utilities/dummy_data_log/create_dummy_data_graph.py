#!/usr/bin/env python3
# coding: UTF-8

import sys
import os
import csv

import pandas as pd
import matplotlib.pyplot as plt

x_label = 'ファイル数'
y_label = '時間'

argvs = sys.argv
if (len(argvs) != 2):
    print('Usage: # python3 %s [FILE PATH]' % argvs[0])
    print('Example: # python3 %s ./measure_dummy_data.csv' % argvs[0])
    quit()

input_file = argvs[1]
if not os.path.isfile(input_file):
    print(input_file + "is not exist")
    quit()

# ファイル読み込み
#df_zfs = pd.read_csv(input_file, encoding="utf-8", names=['files', 'time'])
df_full = pd.read_csv(input_file, encoding="utf-8", names=['files', 'time'])

# データをプロット
#plt.plot(df_zfs['files'], df_zfs['time'], label="zfs")
plt.plot(df_full['files'], df_full['time'], label="full") # TODO: クローン時間差ゲタを履かす

# プロットの設定
plt.legend() # 凡例をグラフにプロット
plt.title('ZFSクローンとFULLクローンのモデル化')
plt.xlabel(x_label)
plt.ylabel(y_label)
plt.xlim(left=0)
plt.ylim(bottom=0)

# ファイル出力と表示
output_file = input_file.replace('csv', 'png') # TODO: ファイル名を考える
plt.savefig(output_file)
plt.show()
