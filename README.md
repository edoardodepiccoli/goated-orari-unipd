# README

idea: 
- store a combo box json with course name: value to send to the server and make the http request
- use can log in, save all of its courses with all the values
- use can directly send it to the server without always having to scrape the combo box with the http request
- find out what request the server actually make to get the lessons schedule for that course, DONE!
- put the app together
- do the same thing for the exams part of it

idea is this
create a job to periodically fetch the courses combo box, update all of the values and names, and reflect the changes for each user
find a way to structure the db so each value to send to the server is linked to a course, AND CAN BE EASILY UPDATES
add auth and make each user store multiple preferred courses
then, on the dashboard or similar simply fetch the couse schedule based on the dates selected by the user

i dont remember how i made it so you can view all lessons, but maybe this is irrelevant, the user only needs one week for now