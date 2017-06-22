metadata = LOAD '/user/maria_dev/ml-100k/u.item'
    USING PigStorage('|') AS (movieID:int, movieTitle:chararray,
    releaseDate:chararray, videoRelease:chararray, imdbLink:chararray);
DUMP metadata;

nameLookup = FOREACH metadata GENERATE movieID, movieTitle,
ToUnixTime(ToDate(releaseDate, 'dd-MMM-yyyy')) AS releaseTime;


ratingsByMovie = GROUP ratings BY movieID;

DUMP ratingsByMovie;

avgRatings = FOREACH   ratingsByMovie GENERATE group AS movieID,
AVG(ratings.rating) AS avgRatings;

DUMP avgRatings;

fiveStarMovies = FILTER avgRatings BY avgRatings > 4.0;0

DESCRIBE ratings;
DESCRIBE ratingsByMovie;
DESCRIBE avgRatings;
