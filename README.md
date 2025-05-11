# README

## Goal

i want to create an app to allow students to see the schedule of their lessons by course. each course has a unique "id", that is what we get in the courses request object, and this course "id" is used to fetch the lesson scheule for each course, allowing the fetching of multiple courses at once. 

i would like to structure it like this
- the app fetches all the courses id once every x days, say once a week or when i tell it to, in order for it to detect changes in the name and id associations, maybe some courses gets added or similar
- the courses ids and courses names gets then associated. i still have to figure out the best way to do it in the db. i was considering creating two tables, or creating a single table with an id, a course server_id or similar and a course name
- the user can then add their favourite courses to its account, then check on the lessons schedule and get a clear cards view of the courses. they can select the time period with a start and finish date. something similar but well working and easy to implement and use
- in order for the user to select their courses, we want them to be able to fuzzy search them by name. then, we want to actually set the course to its favourites. i was wondering how to make the search experience a good and smooth one. i initially thought to prepopulate a select field with all the options of a course, or maybe a datalist with various reccomends, but then i thought that the courses are literally thousands and that could make front end performance shitty and db queries a lot for each course search. i want to ask you the best way to go about it. maybe using hotwire, debouncing or something like that while keeping it stupid simple and highly functional for both me and the users
- do the same for the exams feature but think about this later

come fare a far sì che quando cambiano le lezioni l'utente viene notificato?
si potrebbe fare che un corso ha più lezioni, sarebbe figo registrare tutte quelle dell'anno, in modo da rendere la ricerca più veloce

c'è da trovare il modo per
- capire quando le lezioni vengono cambiate
- trovare quali utenti sono iscritti ai corsi che hanno quelle lezioni
- comunicare il cambiamento delle lezioni via mail

si potrebbe fare in modo che
un corso ha più lezioni
una lezione appartiene solo a un corso
ogni mezz'ora si aggiornano le lezioni e si comunicano i cambiamenti

trovato il modo, perfetto!
ogni lezione è rappresentata nel json ritornato da grid_call.php
nella proprietà "celle", un array, ci sono varie proprietà, tra cui:
- id (buono! si può usare per verificare cambiamenti di orario e posizione)
- (non serve) codice insegnamento -> da usare per linkare i corsi alle lezioni -> forse ha senso direttamente assegnarlo al corso? vabbe lo inserisco e sticazzi
- (non serve) name_original (nome insegnamento completo)
- data
- aula
- ora_inizio
- ora_fine
- docente

attualmente le uniche cose che vengono salvate sono i corsi
salvare tutte le lezioni di tutti i corsi sarebbe un parto
meglio fare così:
- quando uno studente si iscrive a un corso, salviamo tutte le lezioni da oggi a un mese di distanza
- come fare?
- vedi course create action
- a meno che il corso abbia già studenti, inizia a fare il fetch di tutte le lezioni, successivamente fai tutto il resto
- processo di fetch delle lezioni. come funziona? prendi celle, per ognuna di esse, se il codice_insegnamento = course.code allora prendi tutti i dati che ti interessando e builda la lesson sul corso. grande!