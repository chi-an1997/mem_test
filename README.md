# mem_test
Practicing UVM with memory

test plan :
<img width="1024" height="263" alt="image" src="https://github.com/user-attachments/assets/795c1ecf-6656-48c7-bb44-c2f401b850df" />

三種test plan採用extend sequence的方式完成，test plan 1對應mem_seq，test plan 2對應mem_rand_seq, test plan 1對應mem_fixed_pattern_seq

1. Normal Test:
<img width="1982" height="366" alt="image" src="https://github.com/user-attachments/assets/09018097-0bee-4234-bb95-ec58d913de1d" />
從上圖可以看到address以及data都有呈現遞增情況，符合test plan 1 的目標。

跑測試200次，成功200次
<img width="1015" height="853" alt="image" src="https://github.com/user-attachments/assets/4cd031e1-894c-4a88-9d68-126c540e60c5" />


2. Random Test :

<img width="1916" height="376" alt="image" src="https://github.com/user-attachments/assets/be234726-07b6-4676-983a-dd6f1ad11e42" />
從上圖可以看到address以及data都有隨機出現，且寫入讀取皆相同，符合test plan 2 的目標。

跑測試200次，成功200次
<img width="1028" height="883" alt="image" src="https://github.com/user-attachments/assets/3778908b-c8b0-4773-85b8-b173d0ddaea7" />

3. Fixed Pattern Test:
   <img width="2000" height="358" alt="image" src="https://github.com/user-attachments/assets/722d556c-21bd-4313-96a9-f3e67e4c30ec" />
