# README

## Goal

i want to create an app to allow students to see the schedule of their lessons by course. each course has a unique "id", that is what we get in the courses request object, and this course "id" is used to fetch the lesson scheule for each course, allowing the fetching of multiple courses at once. 

i would like to structure it like this
- the app fetches all the courses id once every x days, say once a week or when i tell it to, in order for it to detect changes in the name and id associations, maybe some courses gets added or similar
- the courses ids and courses names gets then associated. i still have to figure out the best way to do it in the db. i was considering creating two tables, or creating a single table with an id, a course server_id or similar and a course name
- the user can then add their favourite courses to its account, then check on the lessons schedule and get a clear cards view of the courses. they can select the time period with a start and finish date. something similar but well working and easy to implement and use
- in order for the user to select their courses, we want them to be able to fuzzy search them by name. then, we want to actually set the course to its favourites. i was wondering how to make the search experience a good and smooth one. i initially thought to prepopulate a select field with all the options of a course, or maybe a datalist with various reccomends, but then i thought that the courses are literally thousands and that could make front end performance shitty and db queries a lot for each course search. i want to ask you the best way to go about it. maybe using hotwire, debouncing or something like that while keeping it stupid simple and highly functional for both me and the users
- do the same for the exams feature but think about this later