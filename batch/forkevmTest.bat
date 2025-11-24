cd ../
wsl bash -lc "mox test --network sepolia --fork"

wsl bash -lc "mox test --network sepolia --fork --coverage"
pause
