import os
import ftplib
from ftplib import FTP
from ftplib import FTP_TLS
bbbip="192.168.7.2"
while True:
        os.system("ifconfig eth0 192.168.5.22")
        ftps = FTP('192.168.5.31')
        #ftps.login('print16-17','123456')
        print "Select an option for transfering files:\n1.Machine to BBB\n2.BBB to machine"
        print "3.BBB to FTP\n4.FTP to BBB\n5.Exit"
        choice = int(input())
        if choice == 1:
                mcip = raw_input("Enter the ip of machine from where the file is to be received: ")
                user = raw_input("Enter the user from  whom the file is to be received: ")
                filename = raw_input("Enter path of the file to be received: ")
                destpath = raw_input("Enter the path where the file is to be stored: ")
                os.system("scp "+user+"@"+mcip+":"+filename+" "+destpath)
                os.system("ls")  
                print "File received successfully"

        elif choice == 2:
                mcip = raw_input("Enter the ip of machine to send files to: ")
                user = raw_input("Enter the user to whom the file is to be sent: ")
                destpath = raw_input("Enter where the file should be stored on receiving machine: ")
                filename = raw_input("Enter the path to the file to be sent: ")
                os.system("scp "+filename+" "+user+"@"+mcip+":"+destpath)
                os.system("ssh "+user+"@"+mcip+" ls")
                print "File successfully sent"
        elif choice==3:
                ftp=ftplib.FTP('192.168.5.31','cnlab','cnlab')
                file_name=raw_input("Enter file to transfer.")
                fh=open(file_name,'rb')
                ftp.storbinary('STOR '+ file_name,fh)
                ftp.retrlines('LIST')
                fh.close()
                print "Upload successful."
        elif choice==4:
                ftp=ftplib.FTP('192.168.5.31','cnlab','cnlab')
                ftp.retrlines('LIST')
                file_path=raw_input("Enter path to Download.")
                opfile = open(file_path,"wb+")
                ftp.retrbinary('RETR '+file_path,opfile.write)
                opfile.close()
                ftp.quit()
                print "File downloaded*"
        else:
                exit()

