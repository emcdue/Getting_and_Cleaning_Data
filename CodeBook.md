## Overview
The <strong>run_analysis.R</strong> script reads data from the <strong>test</strong> and <strong>train</strong> folders and produces <strong>tidy_Data.txt</strong> file output.
This file contains in one row the average of each variable for each subject and activity, regarding only the measurements on the mean and standard deviation for each measurement from teh original data set.

### <br>

## Variables and Data Files
- The <strong>activity_labels.txt</strong> file maps the activity ID to a description of the activity.

- The <strong>features.txt</strong> file contains the columns names for the <strong>X_train.txt</strong> and <strong>X_test.txt</strong> files. More information about the variables could be found in <strong>features_info.txt</strong>

- The following files are available for the <strong>train</strong> and <strong>test</strong> data. Their descriptions are equivalent.

  - <strong>subject_train.txt</strong>: each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

  - <strong>y_train.txt</strong>: each row identifies the type of activity being measured for each window sample. Its range is from 1 to 6.

  - <strong>X_train.txt</strong> contains the data points for each window sample.

### <br>

## Analysis step
* Data downloading
* Load data
* Clean variables/col names
* Merge the train and test data set
* Subset data extrating mean and standard deviation
* Use descriptive activity names
* Appropriately label the data set with descriptive variable names
* Create tidy data set with the average of each variable for each activity and each subject
* File Export