# DWARF
DWARF - is module-managed RMS (Remote Manipulation System) that can bypass almost all security solutions available including a lot of antivirus systems, IPS/IDS, and more.
</br>
![Image](http://wow.zamimg.com/uploads/screenshots/small/59467.jpg) 
</br> > How DWARF systems look

## What is DWARF? 
 
DWARF - is an RMS that is open-source. DWARF can be controlled through console only, and have different techniques which DWARF uses in order to bypass a lot of protection schemes. Actually, I think myself DWARF can bypass any IPS/IDS and antivirus system as well if DWARF will be executed on PC. 

## Is it malware? Why did you posted this? It's illegal!

DWARF is piece of software that was first of all created in order for people to test their own IPS/IDS and antivirus systems and so check whether they're protected from such piece of software, and if not - improve their protection schemes in order to be protected from such piece of software. DWARF can also be used to "spy" on your own hardware, for example when you give laptop access to students and ask them to do something, they might delete all RMS software or just block it somehow, DWARF however is really hard to be blocked and can be very useful in that times. Furthremore, DWARF can be modified (since it's open-source project) and used in a lot of ways, even by government structures who might need to investigate seized computers from another cyber-criminal. 

## Who created this?

This piece of software was created by two people. Information security software designer (me, [Huracan](https://github.com/hyracan/)) and coder ([@denlovefen](https://github.com/denlovefen/)). DWARF was developed in two weeks (including the concept writing and coding).

## What were your motivation to create this?

A lot of companies, government agencies and more were affected by spying using different types of software by other people, in final - they got their private information leaked. We developed DWARF in order for people to check their IPS/IDS and be protected from that type of RMS attacks that can happen on any company or government structure around the world.

## Communication technique that is being used in DWARF

DWARF uses a lot of interesting techniques that were created in order to bypass protection schemes of almost any IPS/IDS how I mentioned before.
DWARF acts as a loader, so basically DWARF do not have anything in itself, except loader and communication.
Communication - realisation is done through SMTP server (mail.ru/yandex.ru/gmail.com , any you else you choose) and supports HTTPS in order to not get HTTP request leaked on IPS/IDS, so we encrypt the communication between you and person on whom RMS is installed, you also not in need of a server to control DWARF, you can do it from your PC on any SMTP server. We can use gmail.com since it's almost all time not restricted on firewalls and no one will think that communication is happening through gmail.com, administrator will think that it's another e-mail you send to your friend.
Everytime hardware receives a command to execute some other module, module itself being downloaded from trusted source (as google disk for example using HTTPS). Modules are however being executed outside the main .exe that is acting as loader and all modules are in .dll

## Default keylogger module

Keylogger module include 2 different modes, default one that will capture everything person type. However, I want to concentrate in description on second mode that is really unique. Every person who work in information security know about formgrabbers that are included in a lot of banking botnets and more, and how every browser right now fight with formgrabbers and protect their users from that, so we went further and bypass any restrictions of browser protection. Second mode will log everything only from window you specify, so for example we're hackers who want to steal your company password that you type in everytime you log into FTP using filezilla application, in order to do that we will capture everything you write in "FileZilla" (yes, you need to fully apply the name including big letters and small letters, or it won't work). Same working with the windows that are in browser (DWARF supports chrome, opera, TOR, internet explorer, to support other browsers you need to modify DWARF yourself, but it will only take you around 5 lines of code), in order to capture several windows in browser, you will need to use something like that: steampaypalfacebook (so steam, paypal, facebook windows are being logged). All logs are going to C&C when command to stop the task come, after logs gone module deletes and clear everything that can afterwards be used in order to detect that module worked on that PC. Keylogger supports cyrillic, saying that just in case, in order to support other you will need to modify DWARF yourself. Also, I want to mention that at the moment of publish (15/10/2016) KeyLogger module is completely undetected by any antivirus system (we checked several,  including Kaspersky with all pro-active protection on and ESET).
![Image](http://i.imgur.com/R13XFAG.png)

## Modules connection

Yes, DWARF supports the connection of other modules to itself as well as small analogue of modules - function of users applications (download .exe file and their start-up with SW_HIDE)

## Other useful information

Auto start-up is being in stealth mode (msconfig shows nothing, nothing is kept in registry, no pop-ups about that file is being started). DWARF is used only under user-mode, no exploits are used as well. Please also mention that there's almost no protection from DWARF being closed by user or antivirus/IPS/IDS, we are not including that so when person will configure the DWARF for their purposes and compile, they can easily stop the process from their testing environment if their IDS/IPS/antivirus won't detect DWARF straight away. Tests of DWARF were done under Windows XP, Windows 8.1 and Windows 10 (yes, we didn't test under windows 7, and we are not going to test under windows 7).
DWARF was coded in Delphi and C++ (modules are in C++, main loader is in Delphi).
DWARF only can be used in Windows, and it was designed only to use in Windows.

## How to compile?
Libraries needed: </br>
ssleay / libeay for SSL </br>
Synapse for Delphi </br>
Compile C++ modules in VS 2015 (Virtual Studio 2015), Delphi (main module which includes C&C and etc) in Delphi.</br>
Do not forget to configure your settings in implant.dpr (mail_accout, mail_password, mail_server, mailsmtpserver, mail_port)

## WARNING BEFORE USE!
Please keep in mind that we didn't test this software anyhow except basic tests of functionality, and please mention that we made some really bad mistakes during the development to make sure that this software is not going to be misused, keep that in mind - person who want to modify DWARF and use it for spying or whatever.

## TODO (or WIP)
Ring0 Rootkit that will hide process and files from task manager and explorer, and also will interrupt WinAPI functions and antivirus/IDS/IPS work, so rootkit will make DWARF 100% invisible from any IPS/IDS/Antivirus system that exists at the moment and protect DWARF from being deleted (persistence). 

## License and terms of usage (TOS)

License is MIT and can be viewed easily in that repository. However, we (coder and me (information security software designer)) are NOT RESPONSIBLE for any actions that you do with that piece of software. If someone will modify DWARF and make it "cyber-criminal weapon", we are not responsible, since that piece of software was created to test your systems, not to get access (or/and spy) on individual(s). PLEASE DO NOT MODIFY DWARF SO IT WILL BE ABLE TO BE USED TO STEAL INFORMATION FROM PEOPLE, SPY ON PEOPLE, AND ETC. PLEASE DO UNDERSTAND THAT THIS PIECE OF SOFTWARE IS ONLY FOR EDUCATIONAL PURPOSES AND MODIFICATION OF YOUR IDS/IPS/ANTIVIRUS SYSTEMS THAT IS BEING DISTRIBUTED AS OPEN-SOURCE.
