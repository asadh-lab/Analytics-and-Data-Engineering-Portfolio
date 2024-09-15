-- Updating the caption of post_id 3

SELECT * FROM posts;

UPDATE posts
SET caption = 'Best Pizza Ever'
WHERE post_id = 3;

-- Selecting all posts where user_id is 1

SELECT * 
FROM posts
WHERE user_id =1;

-- Selecting all the posts and ordering them by created_at descending order
SELECT * FROM posts
ORDER BY created_at DESC;

--counting the number of likes for each posts
-- showing only the posts with more than 2 likes
SELECT p.post_id, count(l.like_id) number_likes FROM posts p
JOIN likes l on p.post_id = l.post_id
Group By p.post_id
HAVING count(l.like_id) >= 2;

-- Finding the total number of likes for all posts
SELECT p.post_id, count(l.like_id) number_likes FROM posts p
JOIN likes l on p.post_id = l.post_id
Group By p.post_id
order by count(l.like_id) desc ;


-- Finding all users who have commented on post_id 1
SELECT name from Users WHERE user_id IN (
SELECT user_id FROM comments WHERE post_id = 1);

-- Ranking the posts based on the number of likes 
WITH cte AS 
(SELECT p.post_id, count(l.like_id) number_likes FROM posts p
JOIN likes l on p.post_id = l.post_id
Group By p.post_id)
	
SELECT 
	post_id, 
	number_likes, 
	DENSE_RANK() OVER (ORDER BY number_likes DESC) rank_by_likes
FROM cte;


-- Finding all the posts and their comments
-- Using a Common Table Expression (CTE)
WITH cte AS (
SELECT p.post_id, p.caption, c.comment_text FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id)
	
SELECT * FROM cte;
