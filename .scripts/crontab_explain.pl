#!/usr/bin/perl -w

# 
# From https://github.com/MeekMark/crontab-explain
# Author:  Mark Stewart
# Useage: Pipe output of crontab -l command into this script:
#crontab -l | crontab-explain.pl
#
#crontab file format:
#minute  hour    day_of_month  month_of_yr  day_of_week   Command
#(0-59)  (0-23)  (1-31)        (1-12)       (0=sun 6=sat) script command
#1,3,10-15      12,18
#        */2  every 2 hours from 00 to 23
#        1-23/4  every 4 hours from 01 to 23
# every x minute not yet supported
#
#       These special time specification "nicknames" which replace the 5 initial time and date fields, and are prefixed with the '@' character, are supported:
#
#       @reboot    :    Run once after reboot.
#       @yearly    :    Run once a year, ie.  "0 0 1 1 *".
#       @annually  :    Run once a year, ie.  "0 0 1 1 *".
#       @monthly   :    Run once a month, ie. "0 0 1 * *".
#       @weekly    :    Run once a week, ie.  "0 0 * * 0".
#       @daily     :    Run once a day, ie.   "0 0 * * *".
#       @hourly    :    Run once an hour, ie. "0 * * * *".


my @day_names = qw( Sun Mon Tue Wed Thu Fri Sat Sun );
my @month_names = qw( ZZZ Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
$DEBUG = defined $ENV{'DEBUG'};

my ($curr_sec,$curr_min,$curr_hour,$curr_mday,$curr_mon,$curr_year,$curr_wday,$curr_yday,$curr_isdst) =
                                                localtime(time);
printf "Current time/date:\n   %02d:%02d:%02d day %d of %s on %s\n",
        $curr_hour,$curr_min,$curr_sec,$curr_mday,$month_names[$curr_mon],$day_names[$curr_wday];

while (<>)
{
        # Ignore lines whose first non-whitespace character is "#"
        #         ^         Beginning of line
        #          \s*      Zero or more whitespace chars
        #             #     "#" char
        next if (/^\s*#/);

        # Check for @ aliases
        if (/^@(reboot|yearly|annually|monthly|weekly|daily|hourly)\s+(.*)/)
        {
                print "$1: invoke the command: $2\n";
                next;
        }

        # Linux allows setting environment vars in crontab.  Sweet!
        #    ^         Beginning of line
        #     \w+      One or more word characters (Alphanumeric or "_")
        #        =     "=" char
        if (/^\w+=.*/)
        {
                print "Environment variable being set: $_";
                next;
        }
        #($minutes, $hours, $day_of_month, $month_of_year, $day_of_week, $command) = split;
        ($minutes, $hours, $day_of_month, $month_of_year, $day_of_week, $command) = split ' ', $_, 6;
        chomp $command;

        #$minutes =~ s/-/\.\./;
        #$minutes_display = eval $minutes;
        #print "minutes: $minutes, minutes_display=$minutes_display, command=$command\n";

        $hours_display = "";
        $hours_phrase = "";
        $hours_wildcard = 0;
        @hours_sorted = ();
        (($DEBUG) && print "HFYI 0: hours=>$hours<=\n");
        if ($hours eq '*')
        {
                $DEBUG && print "HFYI 1a: hours=>$hours<=\n";
                $hours_phrase = " hour";
                $hours_wildcard = 1;
        }
                #            *          character
                #             /         character
                #                numeric characters
        elsif ($hours =~  m!\*/(\d+)!)
        {
                # */2 = every 2nd hour
                # */3 = every 3rd hour
                $DEBUG && print "HFYI 1b: hours=>$hours<=\n";
                $hours_phrase = " $1 hours";
                $hours_wildcard = 1;
        }
        else
        {
                $DEBUG && print "HFYI 1c: hours=>$hours<=\n";
                if ($hours =~ /[-,]/)
                {
                        if ($hours =~ m!(.*)/(.*)!)
                        {
                                # every x hours format: 01-23/x
                                $hours = $1;
                                $hours_every = $2;
                                $DEBUG && print "HFYI 1d: hours=>$hours<= hours_every=>$hours_every<=\n";
                                $hours_wildcard = 1;
                                $hours_phrase = " $2 hours for hours ";
                        }
                        else
                        {
                                $hours_phrase = "on hours";
                        }
                        $DEBUG && print "HFYI 2: hours=>$hours<=\n";
                        # Convert a hyphen to ".." to use Perl's range operator
                        $hours =~ s/-/\.\./;
                        $DEBUG && print "HFYI 3: hours=>$hours<=\n";
                        # Get rid of leading 0 in hours; or eval will assume octal!
                        $hours =~ s/0(\d)/$1/g;
                        $DEBUG && print "HFYI 4: hours=>$hours<=\n";
                        # Numeric sort
                        @hours_sorted = sort {$a <=> $b} (eval $hours);
                        #foreach $hours_item (sort {$a <=> $b} (eval $hours))
                        foreach $hours_item (@hours_sorted)
                        {
                                if (length($hours_display) > 0)
                                {
                                        $hours_display .= ", "
                                }
                                $hours_display .= $hours_item;
                        }
                        $hours_phrase .= " " . $hours_display;
                }
                else
                {
                        $hours_phrase = $hours;
                        @hours_sorted = $hours;
                }
        }
        $DEBUG && print "hours_phrase: $hours_phrase\n";

        $minutes_display = "";
        $minutes_phrase = "";
        $minutes_wildcard = 0;
        @minutes_sorted = ();
        $DEBUG && print "FYI 0: minutes=>$minutes<=\n";
        if ($minutes eq '*')
        {
                $DEBUG && print "FYI 1a: minutes=>$minutes<=\n";
                $minutes_phrase = "on every minute";
                $minutes_wildcard = 1;
        }
        else
        {
                $DEBUG && print "FYI 1b: minutes=>$minutes<=\n";
                if ($minutes =~ /[-,]/)
                {
                        $DEBUG && print "FYI 2: minutes=>$minutes<=\n";
                        # Convert a hyphen to ".." to use Perl's range operator
                        $minutes =~ s/-/\.\./;
                        $DEBUG && print "FYI 3: minutes=>$minutes<=\n";
                        # Get rid of leading 0 in minutes; or eval will assume octal!
                        $minutes =~ s/0(\d)/$1/g;
                        $DEBUG && print "FYI 4: minutes=>$minutes<=\n";
                        # Numeric sort
                        @minutes_sorted = sort {$a <=> $b} (eval $minutes);
                        #foreach $minutes_item (sort {$a <=> $b} (eval $minutes))
                        foreach $minutes_item (@minutes_sorted)
                        {
                                if (length($minutes_display) > 0)
                                {
                                        $minutes_display .= ", "
                                }
                                $minutes_display .= $minutes_item;
                        }
                        $minutes_phrase = $minutes_display;
                }
                else
                {
                        $minutes_phrase = $minutes;
                        @minutes_sorted = $minutes;
                }
        }
        $DEBUG && print "minutes_phrase: $minutes_phrase\n";

        # Now glue the HH and the MM together
        if ($hours_wildcard)
        {
                $hours_of_every = $hours_phrase =~ /on hours/ ? "" : "of every";
                if ($minutes_wildcard)
                {
                        $hhmm_phrase = "On every minute $hours_of_every  $hours_phrase, ";
                }
                else
                {
                        $hhmm_phrase = "At ";
                        # !! To do: append "s" conditionally, and @minutes_sorted
                        $DEBUG && print "XXFYI 0: scalar (\@minutes_sorted)=>" .
                                eval {scalar (@minutes_sorted)}
                                . "<=\n";
                        #!!if ((scalar (@minutes_sorted)) > 1)
                        if (1)
                        {
                                $DEBUG && print "XXFYI 1\n";
                                #$hhmm_phrase .= "s";
                                $loop = 0;
                                foreach $curr_minute (@minutes_sorted)
                                {
                                        if ($loop)
                                        {
                                                $hhmm_phrase .= ", ";
                                        }
                                        $hhmm_phrase .= sprintf("%02ld", $curr_minute);
                                        $loop++;
                                }
                        }
                        #elsif ((scalar (@minutes_sorted)) <= 1)
                        else
                        {
                                $DEBUG && print "XXFYI 2\n";
                                $hhmm_phrase .= " $minutes_phrase";
                        }
                        $hhmm_phrase .= " minutes $hours_of_every $hours_phrase;";
                }

        }
        else
        {
                if ($minutes_wildcard)
                {
                        $hhmm_phrase = "On every minute of hour";
                        $DEBUG && print "HMFYI 0: scalar (\@hours_sorted)=>" .
                                eval {scalar (@hours_sorted)}
                                . "<=\n";
                        #if ((scalar (@hours_sorted)) > 1)
                        #{
                        #       $hhmm_phrase .= "s";
                        #}
                        #elsif ((scalar (@hours_sorted)) == 0)
                        #!!if ((scalar (@hours_sorted)) == 0)
                        if ((scalar (@hours_sorted)) <= 1)
                        {
                                $hhmm_phrase .= sprintf(" %02ld", $hours_phrase);
                        }
                        else
                        {
                                $hhmm_phrase .= "s ";
                                $loop = 0;
                                foreach $curr_hour (@hours_sorted)
                                {
                                        if ($loop)
                                        {
                                                $hhmm_phrase .= ", ";
                                        }
                                        $hhmm_phrase .= sprintf("%02ld", $curr_hour);
                                        $loop++;
                                }
                        }
                }
                else
                {
                        $DEBUG && print "YYFYI 0\n";
                        $hhmm_phrase = "At ";
                        # !! To do: append @hours_sorted:@minutes_sorted
                        # foreach $curr_hour (@hours_sorted)
                        # {
                        #       foreach $curr_minute (@minutes_sorted)
                        #       {
                        #       }
                        # }
                        #if ((scalar (@hours_sorted)) > 1)
                        #{
                                $DEBUG && print "YYFYI 1\n";
                                #$hhmm_phrase .= "s ";
                                $loop = 0;
                                foreach $curr_hour (@hours_sorted)
                                {
                                        foreach $curr_minute (@minutes_sorted)
                                        {
                                                if ($loop)
                                                {
                                                        $hhmm_phrase .= ", ";
                                                }
                                                if ($curr_hour =~ /^\d+$/)
                                                {
                                                        $hhmm_phrase .= sprintf("%02ld:%02ld", $curr_hour, $curr_minute);
                                                }
                                                else
                                                {
                                                        ($hour_list, $hour_repeat) = ($curr_hour =~ /(.*)\/(\d+)$/);
                                                        $hhmm_phrase .= sprintf("%02ld minutes after every %02ld hours from $hour_list", $curr_minute, $hour_repeat);
                                                }
                                                $loop++;
                                        }
                                }
                        #}
                        #elsif ((scalar (@hours_sorted)) <= 1)
                        #{
                        #       print "YYFYI 2\n";
                        #       $hhmm_phrase .= " $hours_phrase, minutes $minutes_phrase";
                        #}
                }
        }


        $day_of_month_display = "";
        if ($day_of_month eq '*')
        {
                $days_phrase = "on every day";
        }
        else
        {
                if ($day_of_month =~ /[-,]/)
                {
                        $day_of_month =~ s/-/\.\./;
                        # Numeric sort
                        foreach $day_of_month_item (sort {$a <=> $b} (eval $day_of_month))
                        {
                                if (length($day_of_month_display) > 0)
                                {
                                        $day_of_month_display .= ", "
                                }
                                $day_of_month_display .= $day_of_month_item;
                        }
                        $days_phrase = "on days " . $day_of_month_display;
                }
                else
                {
                        $days_phrase = "on day " . $day_of_month;
                }
        }

        $day_of_week_phrase = "";
        if ($day_of_week eq '*')
        {
                        $day_of_week_phrase = "of every weekday";
        }
        else
        {
                $day_of_week_phrase = "that fall on ";
                if ($day_of_week =~ /[-,]/)
                {
                        $day_of_week =~ s/-/\.\./;
                        # Values are less than 10 so just regular sort is fine here
                        foreach $day_of_week_item (sort (eval $day_of_week))
                        {
                                if (length($day_of_week_phrase) > length("that fall on "))
                                {
                                        $day_of_week_phrase .= ", ";
                                }
                                $day_of_week_phrase .= $day_names[$day_of_week_item];
                        }
                }
                else
                {
                        $day_of_week_phrase .= $day_names[$day_of_week] . " ";
                }
        }

        $months_phrase = "";
        if ($month_of_year eq '*')
        {
                        $months_phrase = "of every month";
        }
        else
        {
                $months_phrase = "in ";
                if ($month_of_year =~ /[-,]/)
                {
                        $month_of_year =~ s/-/\.\./;
                        # Numeric sort
                        foreach $month_item (sort {$a <=> $b} (eval $month_of_year))
                        {
                                if (length($months_phrase) > 3)
                                {
                                        $months_phrase .= ", ";
                                }
                                $months_phrase .= $month_names[$month_item];
                        }
                }
                else
                {
                        $months_phrase .= $month_names[$month_of_year];
                }
        }

        #print "day_of_month: $day_of_month, day_of_month_display=$day_of_month_display, command=$command\n";
        #print "$hhmm_phrase $days_phrase $months_phrase $day_of_week_phrase invoke the command: $command\n";
        # Grab last command and its arguments.  Usually the last command is the one of interest.
        # Split on the last semicolon in the command that is not preceeded by a "\" (to avoid getting
        # confused by a
        #     find . -exec rm {} \;
        # )
        @command_list = split /[^\\];/, $command;
        $last_command_name = pop @command_list;
        # Get rid of redirection noise
        $last_command_name =~ s/(>\s*\S+)\s?(2>\s*\S+)?//;
        print "$hhmm_phrase $days_phrase $months_phrase $day_of_week_phrase invoke the command: $last_command_name\n";
        $DEBUG && print "full command=>$command<=\n";
}
