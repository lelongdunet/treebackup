# Selective incremental backup system

TreeBackup is an incremental data backup system based on [DAR archives](http://dar.linux.free.fr/). It allows to keep your data safe with a selective history of archives.
Seletive history means here that your data can be saved every days with a long term history without keeping
archives of all days for years.

## Presentation

DAR is a powerful archive system allowing to build differential archives. It has also other advantages over classical TAR archives that you can find
on the [project website](http://dar.linux.free.fr/).

Backups are DAR archives that are created in a local directory. To implement a full backup strategy, TreeBackup provide a mirror feature allowing to duplicate the
local backup on a remote host using rsync protocol.

## Backup strategy

One of the main purpose of TreeBackup is to make differential backup and to perform a progressive deletion of certain archives in the history. The default backup strategy is to perform
one backup each days. All backup are kept for one to two month so that at least 30 consecutive days can always be found in the backup history. For each month, one backup is kept for at least one year so that between 12 and 24 consecutive month can be found in the history. For older archives, only one by year is kept for ever.

This strategy allows to keep track of very old data without overloading the backup history. In the next section of this documentation, you can see an example of backup history with this strategy after two years of daily backup.

## Installation and prerequisites

TreeBackup is written using bash scripting language. The only 2 prerequisites is bash itself and DAR. You should find it as a standard package in most distributions. If you are using Debian like (Ubuntu, Mint ...) distributions, you can simply run
```bash
apt-get install dar
```

Then, run the script `setup` script as root with the command
```bash
./setup
```
After you shoud be able to run the command
```bash
treebackup
```

Now TreeBackup is installed on your machine you can try to make your first backup as described in next paragraph.

## Basic usage example

We want here to backup the directory `$HOME/data`

Let's create a new profile associated with the `data` directory. Edit the file `$HOME/.treebackup/data` and add the following content :
```
BACKUPPATH="$HOME/.backup"
ROOTPATH="$HOME/data"
DAROPTIONS='-z'
datadir='data'
```
These four parameters are the basic configuration of a TreeBackup profile. `BACKUPPATH` is the path of the directory containing backups (generally all profiles have the same
value for it). `ROOTPATH` is the path of the directory containing files to backup. `DAROPTIONS` is a string with the list of options to pass to DAR archive creator. Here the option
`-z` tell DAR to use gzip to compress all files. Finally `datadir` contains the name of the subdirectoy to create in `$HOME/.backup` that will receive all archives and meta data of backups.

Once the profile is created, the first backup can be made with the command
```bash
treebackup data
```

Available backups can be listed with the command
```bash
treebackup data list
```
Here this command give the following result :
```
Backup of profile data, ROOT=/home/ad/data to /home/ad/.backup
  2014-04-07 17:37   (data.master)
```
The `list` command display the backup history with the date of each backup and its full name.
The name of the of the first backup ends always with `.master` as it corresponds to the master base archive.
This master archive contains all the files at the date of the initial backup.

On the day after, if you run again the command
```bash
treebackup data
```
You obtain the following history
```
Backup of profile data, ROOT=/home/ad/data to /home/ad/.backup
  2014-04-07 17:37   (data.master)
  2014-04-07 17:40   (data.14-6-0-8)

```
As you can see, each following backup name is suffixed with the date.

## Remote backup (mirror) creation

_TO BE COMPLETED_

## Customize archive creation

_TO BE COMPLETED_

## Tips for testing

Any date can be simulated by exporting environment variables
```bash
$fakeday
$fakemonth
$fakeyear
```

For example to simulate a backup created on Tuesday 1st October 2013, run the following command sequence :
```bash
export fakeday=01
export fakemonth=10
export fakeyear=2013
treebackup data
```

## Example of backup history

We keep our example of data directory backup. Let's consider an automatic backup started in year 2012 and listed in April 2014.
The command
```bash
treebackup data list
```
gives this output :
```
  2012-12-13 19:48   (data.master)
  2013-01-02 10:05   (data.13)
  2013-02-02 22:25   (data.13-02)
  2013-03-02 22:40   (data.13-03)
  2013-04-04 16:40   (data.13-04)
  2013-05-01 03:18   (data.13-05)
  2013-06-01 03:18   (data.13-06)
  2013-07-01 03:23   (data.13-07)
  2013-08-01 03:14   (data.13-08)
  2013-09-01 03:12   (data.13-09)
  2013-10-01 03:14   (data.13-10)
  2013-11-01 03:16   (data.13-11)
  2013-12-01 03:30   (data.13-12)
  2014-01-01 04:37   (data.14)
  2014-02-01 03:15   (data.14-02)
  2014-03-01 03:21   (data.14-03)
  2014-03-02 03:14   (data.14-03-0-02)
  2014-03-03 03:13   (data.14-03-0-03)
  2014-03-04 03:13   (data.14-03-0-04)
  2014-03-05 03:13   (data.14-03-0-05)
  2014-03-06 03:14   (data.14-03-0-06)
  2014-03-07 03:14   (data.14-03-0-07)
  2014-03-08 03:14   (data.14-03-0-08)
  2014-03-09 03:13   (data.14-03-0-09)
  2014-03-10 03:13   (data.14-03-0-10)
  2014-03-11 03:14   (data.14-03-0-11)
  2014-03-12 03:13   (data.14-03-0-12)
  2014-03-13 03:14   (data.14-03-0-13)
  2014-03-14 03:14   (data.14-03-0-14)
  2014-03-15 03:14   (data.14-03-0-15)
  2014-03-16 03:13   (data.14-03-0-16)
  2014-03-17 03:12   (data.14-03-0-17)
  2014-03-18 03:14   (data.14-03-0-18)
  2014-03-19 03:14   (data.14-03-0-19)
  2014-03-20 03:14   (data.14-03-0-20)
  2014-03-21 03:14   (data.14-03-0-21)
  2014-03-22 03:14   (data.14-03-0-22)
  2014-03-23 03:14   (data.14-03-0-23)
  2014-03-24 03:14   (data.14-03-0-24)
  2014-03-25 03:13   (data.14-03-0-25)
  2014-03-26 03:14   (data.14-03-0-26)
  2014-03-27 03:13   (data.14-03-0-27)
  2014-03-28 03:14   (data.14-03-0-28)
  2014-03-29 03:13   (data.14-03-0-29)
  2014-03-30 03:14   (data.14-03-0-30)
  2014-03-31 03:13   (data.14-03-0-31)
  2014-04-01 03:15   (data.14-04)
  2014-04-02 03:13   (data.14-04-0-02)
  2014-04-03 03:13   (data.14-04-0-03)
  2014-04-04 03:14   (data.14-04-0-04)
  2014-04-05 03:14   (data.14-04-0-05)
  2014-04-06 03:14   (data.14-04-0-06)
  2014-04-07 03:13   (data.14-04-0-07)
```
