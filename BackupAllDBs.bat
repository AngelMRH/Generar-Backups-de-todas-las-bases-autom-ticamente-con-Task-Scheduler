@echo off
sqlcmd -S .\COMPAC -E -i "C:\Scripts\BackupAllDBs.sql" -o "C:\Scripts\log.txt"
pause
