#!/bin/bash

################################################################################
##                       Cloud Computing Course                               ##
##          Runner Script for Project Machine Learning on the Cloud           ##
##                                                                            ##
##            Copyright 2018-2019: Cloud Computing Course                     ##
##                     Carnegie Mellon University                             ##
##   Unauthorized distribution of copyrighted material, including             ##
##  unauthorized peer-to-peer file sharing, may subject the students          ##
##  to the fullest extent of Carnegie Mellon University copyright policies.   ##
################################################################################

################################################################################
##                      README Before You Start                               ##
################################################################################
# Fill in the functions below for each question.
# You may use any programming language(s) in any question.
# You may use other files or scripts in these functions as long as they are in
# the submission folder.
# All files MUST include source code (e.g., do not just submit jar or pyc files).
#
# We will suggest tools or libraries in each question to enrich your learning.
# You are allowed to solve questions without the recommended tools or libraries.
#
# The colon `:` is a POSIX built-in basically equivalent to the `true` command,
# REPLACE it with your own command in each function.
# Before you fill your solution,
# DO NOT remove the colon or the function will break because the bash functions
# may not be empty!


################################################################################
##                          Setup & Cleanup                                   ##
################################################################################

setup() {
  # Fill in this helper function to do any setup if you need to.
  #
  # This function will be executed once at the beginning of the grading process.
  # Other functions may be executed repeatedly in arbitrary order.
  # Make use of this function to reduce any unnecessary overhead and to make your
  # code behave consistently.
  #
  # e.g., You should compile any code in this function.
  #
  # However, DO NOT use this function to solve any question or
  # generate any intermediate output.
  #
  # Examples:
  # mvn clean package
  # pip3 install -r requirements.txt
  #
  # Standard output format:
  # No standard output needed

  # convert the notebook into an executable Python script (DO NOT remove)
  jupyter nbconvert data_analysis.ipynb --to python --TagRemovePreprocessor.remove_input_tags='["excluded_from_script"]'

}

cleanup() {
  # Fill this helper function to clean up if you need to.
  #
  # This function will be executed once at the end of the grading process.
  # Other functions might be executed repeatedly in arbitrary order.
  #
  # Examples:
  # mvn clean
  :
}


q1() {
  python3 data_analysis.py -r q1
}

q2() {
  python3 data_analysis.py -r q2
}

q3() {
  python3 data_analysis.py -r q3
}

q4() {
  python3 data_analysis.py -r q4
}


################################################################################
##                    DO NOT MODIFY ANYTHING BELOW                            ##
################################################################################

declare -ar questions=( "q1" "q2" "q3" "q4")

readonly usage="This program is used to execute your solution.
Usage:
./runner.sh to run all the questions
./runner.sh -r <question_id> to run one single question
./runner.sh -s to run setup() function
./runner.sh -c to run cleanup() function
Example:
./runner.sh -r q1 to run q1"

contains() {
  local e
  for e in "${@:2}"; do
    [[ "$e" == "$1" ]] && return 0;
  done
  return 1
}

while getopts ":hr:sc" opt; do
  case ${opt} in
    h)
      echo "$usage" >&2
      exit
    ;;
    s)
      setup
      echo "setup() function executed" >&2
      exit
    ;;
    c)
      cleanup
      echo "cleanup() function executed" >&2
      exit
    ;;
    r)
      question=$OPTARG
      if contains "$question" "${questions[@]}"; then
        answer=$("$question")
        echo -n "$answer"
      else
        echo "Invalid question id" >&2
        echo "$usage" >&2
        exit 2
      fi
      exit
    ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo "$usage" >&2
      exit 2
    ;;
  esac
done

if [ -z "$1" ]; then
  setup 1>&2
  echo "setup() function executed" >&2
  echo "The answers generated by executing your solution are: " >&2

  for question in "${questions[@]}"; do
    echo "$question:"
    result="$("$question")"
    if [[ "$result" ]]; then
      echo "$result"
    else
      echo ""
    fi
  done
  cleanup 1>&2
  echo "cleanup() function executed" >&2
  echo "If you feel these values are correct please run:" >&2
  echo "./submitter" >&2
else
  echo "Invalid usage" >&2
  echo "$usage" >&2
  exit 2
fi
