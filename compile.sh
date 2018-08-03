#!/bin/bash

module load matlab

log=compiled/commit_ids.txt
true > $log
echo "/N/u/brlife/encode-dp" >> $log
(cd /N/u/brlife/git/encode && git log -1) >> $log
echo "/N/u/brlife/git/vistasoft" >> $log
(cd /N/u/brlife/git/vistasoft && git log -1) >> $log
echo "/N/u/brlife/git/jsonlab" >> $log
(cd /N/u/brlife/git/jsonlab && git log -1) >> $log

cat > build.m <<END
addpath(genpath('/N/u/brlife/git/encode-dp'));
addpath(genpath('/N/u/brlife/git/vistasoft'));
addpath(genpath('/N/u/brlife/git/jsonlab'));

mcc -m -R -nodisplay -a /N/u/brlife/git/vistasoft/mrAnatomy/Segment -d compiled fit_model
mcc -m -R -nodisplay -a /N/u/brlife/git/vistasoft/mrAnatomy/Segment -d compiled find_best
exit
END
matlab -nodisplay -nosplash -r build && rm build.m

