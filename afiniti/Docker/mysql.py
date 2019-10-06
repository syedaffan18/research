import pymysql,os,sys
from itertools import combinations


def longest_palindrome(s):
    pal = ''
    length = 0
    for i, j in combinations(range(len(s)+1), 2): #all combinations of indices
        subString = s[i:j]
        #if new length of substring is greater than lenngth and is a palindrome
        if (len(subString) > length) and (subString == subString[::-1]):
            pal = subString
            length = len(subString)
    return pal

def longest_pal():
    lp = longest_palindrome(sys.argv[1])
    print(os.getenv("MYSQL_ROOT_PASSWORD"))
    connection = pymysql.connect(host=os.getenv("DB_HOST"),port=int(os.getenv("DB_PORT")), user=os.getenv("MYSQL_ROOT_USER"),database=os.getenv("MYSQL_DATABASE"), password=os.getenv("MYSQL_ROOT_PASSWORD"),charset='utf8mb4',cursorclass=pymysql.cursors.DictCursor)
 
    try:
        with connection.cursor() as cursor:
            # Create a new record
            sql = "INSERT INTO `stringlog` (`StringVal`) VALUES (%s)"
            cursor.execute(sql, (lp))

        # connection is not autocommit by default. So you must commit to save
        # your changes.
        connection.commit()

        with connection.cursor() as cursor:
            # Read a single record
            sql = "SELECT StringVal FROM `stringlog`"
            cursor.execute(sql)
            result = cursor.fetchall()
            print(result)
    finally:
        connection.close()

print (longest_pal())