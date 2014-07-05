-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 19 May 2014 la 16:54
-- Server version: 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `yourcinema`
--

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `actor`
--

CREATE TABLE IF NOT EXISTS `actor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `birth_place` varchar(100) NOT NULL,
  `birth_date` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `biography` text NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `views` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=26 ;

--
-- Salvarea datelor din tabel `actor`
--

INSERT INTO `actor` (`id`, `first_name`, `last_name`, `birth_place`, `birth_date`, `country`, `biography`, `picture`, `views`) VALUES
(1, 'Zooey', 'Deschanel', 'Los Angeles', '17 January 1980', 'USA', 'Zooey Deschanel was born in 1980 into a showbiz family. Her father, Caleb Deschanel, is an Academy Award-nominated cinematographer (perhaps most notably for The Passion of the Christ (2004)) and her mother, Mary Jo Deschanel (née Weir), is an actress who appeared in Twin Peaks (1990). Driven from an early age to become a successful actress, Zooey got her big break, at age 17, playing a model in the TV sitcom, Veronica''s Closet (1997). She got her first film role, the following year, in Mumford (1999), which prompted her to quit university to pursue acting full-time. Mostly thanks to a role in Cameron Crowe''s popular biopic, Almost Famous (2000), Zooey''s rise to fame has been steadily increasing as the 21st century wears on. Her distinctive acting style found her critical acclaim in 2003, when she was voted Best Actress at the Mar Del Plata Film Festival for her role in David Gordon Green''s All the Real Girls (2003). She also gained a Best Female Lead nomination (for All the Real Girls (2003)) at the following year''s Independent Spirit Awards, but lost out to Charlize Theron.\r\n\r\nZooey has appeared in such films as (500) Days of Summer (2009), Our Idiot Brother (2011), Yes Man (2008) (opposite Jim Carrey), Elf (2003) (opposite Will Farrell), Maria ta (2011), The Happening (2008) (opposite Mark Wahlberg), The Hitchhiker''s Guide to the Galaxy (2005) and is the star of the FOX sitcom, New Girl (2011).\r\n\r\nZooey is often compared to golden era Hollywood starlets and is also a talented singer. She has said in interviews that she believes her singing ability was pivotal in gaining the role of "Jovie" in Elf (2003). She also sang (and acted) in the Disney-produced musical, Once Upon a Mattress (2005).', 'zooey_deschanel.jpg', 0),
(2, 'Joseph', 'Leonard Gordon-Levitt', 'Los Angeles', '17 February 1981', 'USA', 'Joseph Leonard Gordon-Levitt was born on February 17, 1981 in Los Angeles, California to parents Jane Gordon and Dennis Levitt. Joseph was raised in a Jewish family with his late older brother, Dan Gordon-Levitt, who passed away in October 2010. His maternal grandfather, Michael Gordon, had been a well-known movie director. After working for several years as a child actor, Joseph became better known for starring on the hit television series 3rd Rock from the Sun (1996), for which he earned two Hollywood Reporter Young Star Awards. In addition, the show earned three Screen Actors Guild Award nominations for Outstanding Peformance by an Ensemble in a Comedy Series. Prior to his success on television, Joseph had already worked steadily in feature films, debuting in the Robert Redford film Cândva pe aici trecea un râu (1992). He won a Young Artist Award for the latter film. During the 1990s, he also co-starred in the films Angels in the Outfield (1994), The Juror (1996), Halloween H20: 20 Years Later (1998), and 10 Things I Hate About You (1999).\r\n\r\nFollowing his work on 3rd Rock from the Sun (1996), Joseph took time off from acting to attend Columbia University. In the early 2000s, he broke from the mold of his television and film comedy supporting roles by appearing in a string of intense dramatic roles, mostly in smaller, independent films such as Manic (2001), with Don Cheadle; Mysterious Skin (2004), for writer/director Gregg Araki; Rian Johnson''s award-winning debut film, Brick (2005); Lee Daniels'' Shadowboxer (2005); the crime drama The Lookout (2007), which marked Scott Frank''s directorial debut; John Madden''s Killshot (2008), with Diane Lane and Mickey Rourke; and the controversial drama Stop-Loss (2008), in which he starred with Ryan Phillippe, under the direction of Kimberly Peirce. By 2009, Joseph was officially established as one of the leading men of indie cinema with his Golden Globe-nominated role in the comedy-drama (500) Days of Summer (2009), for which he also received an Independent Spirit Award nod. He also adapted the Elmore Leonard short story Sparks into a 24-minute short film that he directed (Sundance Film Festival 2009).\r\n\r\nIn 2010, he headlined the indie drama Hesher (2010) and also established himself as a mainstream star in Christopher Nolan''s Începutul (2010). Balancing both independent and Hollywood film, Joseph scored another Golden Globe nod for the cancer drama 50/50 (2011), directed by Jonathan Levine and also starring Seth Rogen, Anna Kendrick, and Bryce Dallas Howard. He worked again with director Nolan on The Dark Knight Rises (2012) (for which he received a People''s Choice Award nomination for Favorite Movie Actor), and snagged leading roles in both Premium Rush (2012), directed by David Koepp, and Looper (2012), for which he reunited with his Brick director, Rian Johnson, and starred opposite Bruce Willis and Emily Blunt. Also in 2012, he played Abraham Lincoln''s son Robert in Steven Spielberg''s Oscar-nominated Lincoln (2012), with Daniel Day-Lewis and Sally Field.\r\n\r\nIn 2013, Joseph Gordon-Levitt starred in his critically-acclaimed feature film directorial debut, Don Jon, from a script he wrote, opposite Scarlett Johansson and Julianne Moore. He was nominated for an Independent Spirit Award for "Best First Screenplay" for the film. Gordon-Levitt provided the voice of Jiro Horikoshi in the 2014 English-language version of Hayao Miyazaki''s Academy Award-nominated animated feature The Wind Rises, and will appear in Robert Rodriguez and Frank Miller''s Sin City: A Dame To Kill For, in which he plays Johnny, a character Miller created for the film.\r\n\r\nGordon-Levitt founded and directs hitRECord, an open collaborative production. hitRECord creates and develops art and media collectively using their website where anyone with an internet connection can upload their records, download and remix others'' records, and work on projects together. When the results of these RECords are produced and make money, hitRECord splits the profits 50/50 with everybody who contributed to the final production. hitRECord has published books, put out records, gone on tour and has screened their work at major festivals including Sundance and TIFF. "RegularJOE" (as he''s known on the site) is leading the community of over 300, 000 artists in its biggest collaboration yet, a new take on a variety show called "HitRecord on TV!" The half hour series, which Gordon-Levitt hosts, premiered in January on Participant Media''s new cable network, Pivot and has recently been renewed for a second season.', 'joseph_levitt.jpg', 0),
(3, 'Sam', 'Worthington', 'Godalming, Surrey, England', 'August 2, 1976', 'United Kingdom', 'Sam Worthington was born on August 2, 1976 in Surrey, England. His parents, Jeanne and Ronald Worthington, moved the family to Australia when he was six months old, and raised him and his sister Lucinda in Warnbro, a suburb of Perth, Western Australia.\r\n\r\nWorthington graduated from NIDA (Australia''s National Institute of Dramatic Art) in 1998 at the age of 22. He received critical acclaim for his portrayal of "Arthur Wellesley" in his first professional role in the Belvoir Street Theatre production "Judas Kiss" (directed by Neil Armfield). He then went on to work in Australian television on such shows as Water Rats (1996) and "Backburner" and then on the American TV show Justitie militara (1995)''s 100th episode (Boomerang: Part 1).\r\n\r\nWorthington made his film debut in the highly acclaimed Australian movie Bootmen (2000), a film about a troop of "tap dogs". Minor roles proceeded in Razboiul lui Tom Hart (2002) and A Matter of Life (2001) before he was cast in another hailed Australian drama, Dirty Deeds (2002), co-starring Toni Collette and John Goodman.\r\n\r\nThe following year, he starred in yet another Aussie film, opposite David Wenham in Gettin'' Square (2003). The director of the film, Jonathan Teplitzky, originally tested actors who were up to 8 years older than the then-27-year-old Worthington. Teplitzky wasn''t sure Sam "could convincingly play a tough guy and also have elements of the leading man about him", but in the end Teplitzky decided he was "fantastic", and had "David playing the older, slightly more streetwise accomplice" proclaiming "it worked".\r\n\r\nBut it wasn''t until 2004 that Sam got his big break. He was offered the starring role in Cate Shortland''s acclaimed Australian drama Somersault (2004), opposite Abbie Cornish. The film made a clean sweep of the Australian Film Institute awards in 2004, winning in 13 film categories - the first time this has ever occurred in the award''s history. Worthington also won the AFI award for Best Male Actor. \r\n\r\nWorthington''s career took off internationally when he was cast as Jake Sully in James Cameron''s Avatar (2009) and as Marcus Wright, a cyborg who assists the humans despite their suspicions of him in Terminator - Salvarea (2009). Worthington soon became a household name, and starring in high profile films Infruntarea titanilor (2010), The Debt (2010), Texas Killing Fields (2011), Dreptate la înaltime (2012), and Furia titanilor (2012). Worthington also provided the voice for the Call of Duty: Black Ops video games. \r\n\r\nIn 2010, Worthington started a production company, Full Clip Productions, with two of his close friends John Schwarz and Michael Schwarz. The company teamed with Radical studios to print two graphic novels Damaged and Patriots.', 'sam_worthington.jpg', 0),
(4, 'Zoe', 'Saldana', 'Zoë Yadira Saldaña Nazario ', 'June 19, 1978', 'USA', 'Zoe Saldana was born in New Jersey and raised in Queens, New York. When she was 10 years old, she and her family moved to the Dominican Republic where they would live for the next 7 years. While living in the Dominican Republic, Zoe discovered a keen interest in performance dance and began her training at the prestigious ECOS Espacio de Danza Dance Academy where she learned ballet as well as other dance forms. Not only did her training provide an excellent outlet for the enthusiastic and energetic youngster, it would also prove to be a fortunate precursor for the start of her professional acting career. At age 17, Zoe and her family moved back to the United States where her love for dance followed and an interest in theater performance became stronger. She began performing with the Faces theater troupe which put on plays geared to provide positive messages for teens with themes dealing with issues such as substance abuse and sex. These performances not only gave her valuable experience but also a source of great pride knowing that she was making a difference in the lives of young people like herself. While performing with the Faces troupe and also the New York Youth Theater, Zoe was recruited for a talent agency and her dance training years before coupled with her acting experience greatly helped her land her first big screen role as "Eva Rodriguez", the talented and headstrong ballet dancer in the film Center Stage (2000). Since her professional career began just a few years ago, Zoe''s talent and determination has allowed her to be involved in blockbuster films and act with major actors, actresses and industry insiders at a pace that very few young professionals have experienced. Zoe has not only held her own in major motion picture productions but gained the respect and praise from industry insiders such as Jerry Bruckheimer and Steven Spielberg and actors/actresses such as Tom Hanks, Bernie Mac, Keira Knightley, Ashton Kutcher, Kirsten Dunst and Orlando Bloom. According to many of her costars, producers, and directors, the sky is no limit for this young star who has incredible range, intense concentration, and a steely determination to be involved with projects that challenge her professionally with wide-ranging subject matters and characters. Just to ask practically anyone who she has worked for or with about her, glowing comments abound and earned friendships and respect are readily revealed. A star has been born, and growing every day.', 'zoe_saldana.jpg', 0),
(5, 'Sigourney', 'Weaver', 'New York City, New York', 'October 8, 1949', 'USA', 'Sigourney Weaver was born Susan Alexandra Weaver in Leroy Hospital in New York City. Her father, TV producer Sylvester L. Weaver Jr., originally wanted to name her Flavia, because of his passion for Roman history (he had already named her elder brother Trajan). Her mother, Elizabeth Inglis, was a British actress who had sacrificed her career for a family. Sigourney grew up in a virtual bubble of guiltless bliss, being taken care by nannies and maids. By 1959, the Weavers had resided in 30 different households. In 1961, Sigourney began attending the Brearley Girls Academy, but her mother moved her to another New York private school, Chapin. Sigourney was quite a bit taller than most of her other classmates (at the age of 13, she was already 5\\\\\\\\\\\\\\'' 10\\\\\\\\\\\\\\"), resulting in her constantly being laughed at and picked on; in order to gain their acceptance, she took on the role of class clown.\\\\\\\\r\\\\\\\\n\\\\\\\\r\\\\\\\\nIn 1962, her family moved to San Francisco briefly, an unpleasant experience for her. Later, they moved back east to Connecticut, where she became a student at the Ethel Walker School, facing the same problems as before. In 1963, she changed her name to \\\\\\\\\\\\\\"Sigourney\\\\\\\\\\\\\\", after the character \\\\\\\\\\\\\\"Sigourney Howard\\\\\\\\\\\\\\" in F. Scott Fitzgerald\\\\\\\\\\\\\\''s \\\\\\\\\\\\\\"The Great Gatsby\\\\\\\\\\\\\\" (her own birth name, Susan, was in honor of her mother\\\\\\\\\\\\\\''s best friend, explorer Susan Pretzlik). Sigourney had already starred in a school drama production of \\\\\\\\\\\\\\"A Midsummer Night\\\\\\\\\\\\\\''s Dream\\\\\\\\\\\\\\", and, in 1965, she worked during the summer with a stock troupe, performing in \\\\\\\\\\\\\\"A Streetcar Named Desire\\\\\\\\\\\\\\" and \\\\\\\\\\\\\\"You Can\\\\\\\\\\\\\\''t Take It With You\\\\\\\\\\\\\\" (she didn\\\\\\\\\\\\\\''t star in the latter because she was taller than the lead actor!). After graduating from school in 1967, she spent some months in a kibbutz in Israel. At that time, she became engaged to reporter Aaron Latham, but they soon broke up.\\\\\\\\r\\\\\\\\n\\\\\\\\r\\\\\\\\nIn 1969, Sigourney enrolled in Stanford University, majoring in English Literature. She also participated in school plays, especially Japanese Noh plays. By that time she was living in a tree house, alongside a male friend, dressed in elf-like clothes! After completing her studies in 1971, she applied for the Yale School of Drama in New Haven. Despite appearing at the audition reading a Bertolt Brecht speech and wearing a rope-like belt, she was accepted by the school but her professors rejected her, because of her height, and kept typecasting her as prostitutes and old women (whereas classmate Meryl Streep was treated almost reverently). However, in 1973, while making her theatrical debut with \\\\\\\\\\\\\\"Watergate Classics\\\\\\\\\\\\\\", she met up with a team of playwrights and actors and began hanging around with them, resulting in long-term friendships with Christopher Durang, Kate McGregor-Stewart and Albert Innaurato.\\\\\\\\r\\\\\\\\n\\\\\\\\r\\\\\\\\nIn 1974, she starred in such plays as Aristophanes\\\\\\\\\\\\\\'' \\\\\\\\\\\\\\"Frogs\\\\\\\\\\\\\\" and Durang\\\\\\\\\\\\\\''s \\\\\\\\\\\\\\"The Nature and Purpose of the Universe\\\\\\\\\\\\\\" and \\\\\\\\\\\\\\"Daryl and Carol and Kenny and Jenny\\\\\\\\\\\\\\", as \\\\\\\\\\\\\\"Jenny\\\\\\\\\\\\\\". After finishing her studies that year, she began seriously pursuing a stage career, but her height kept being a hindrance. However, she continued working on stage with Durang (in \\\\\\\\\\\\\\"Titanic\\\\\\\\\\\\\\" [1975]) and Innaurato (in \\\\\\\\\\\\\\"Gemini\\\\\\\\\\\\\\" [1976]). Other 1970s stage works included \\\\\\\\\\\\\\"Marco Polo Sing a Song\\\\\\\\\\\\\\", \\\\\\\\\\\\\\"The Animal Kingdom\\\\\\\\\\\\\\", \\\\\\\\\\\\\\"A Flea in Her Ear\\\\\\\\\\\\\\", \\\\\\\\\\\\\\"The Constant Husband\\\\\\\\\\\\\\", \\\\\\\\\\\\\\"Conjuring an Event\\\\\\\\\\\\\\" and others. However, the one that really got her noticed was \\\\\\\\\\\\\\"Das Lusitania Songspiel\\\\\\\\\\\\\\", a play she co-wrote with Durang and in which she starred for two seasons, from 1979 to 1981. She was also up for a Drama Desk Award for it. During the mid-70s, she appeared in several TV spots and even starred as \\\\\\\\\\\\\\"Avis Ryan\\\\\\\\\\\\\\" in the soap opera Somerset (1970).\\\\\\\\r\\\\\\\\n\\\\\\\\r\\\\\\\\nIn 1977, she was cast in the role Shelley Duvall finally played in Annie Hall (1977), after rejecting the part due to prior stage commitments. In the end, however, Woody Allen offered her a part in the film that, while short (she was on-screen for six seconds), made many people sit up and take notice. She later appeared in Madman (1978) and, of course, Alien (1979). The role of the tough, uncompromising \\\\\\\\\\\\\\"Ripley\\\\\\\\\\\\\\" made Sigourney an \\\\\\\\\\\\\\"overnight\\\\\\\\\\\\\\" star and brought her a British Award Nomination. She next appeared in Eyewitness (1981) and The Year of Living Dangerously (1982), the latter being a great success in Australia that won an Oscar and brought Sigourney and co-star Mel Gibson to Cannes in 1983. The same year she delivered an honorary Emmy award to her father, a few months before her uncle, actor Doodles Weaver, committed suicide. That year also brought her a romance with Jim Simpson, her first since having broken up two years previously with James M. McClure. She and Simpson were married on 1 October 1984. Sigourney had, meanwhile, played in the poorly received Deal of the Century (1983) and the mega-hit Ghost Busters (1984). She was also nominated for a Tony Award for her tour-de-force performance in the play \\\\\\\\\\\\\\"Hurly Burly\\\\\\\\\\\\\\". Then followed Une femme ou deux (1985), Half Moon Street (1986) and Aliens - Misiune de pedeapsa (1986). The latter was a huge success, and Sigourney was nominated for both a Golden Globe and an Oscar.\\\\\\\\r\\\\\\\\n\\\\\\\\r\\\\\\\\nShe then entered her most productive career period and snatched Academy Award nominations, in both Best Actress and Best Supporting Actress categories, for her intense portrayal of Dian Fossey in Gorillas in the Mist: The Story of Dian Fossey (1988) and her delicious performance as a double-crossing, power-hungry corporate executive in O femeie face cariera (1988). She ended up losing in both, but made up for it to a degree by winning both Golden Globes. After appearing in a documentary about fashion photographer Helmut Newton, Helmut Newton: Frames from the Edge (1989), and reprising her role in the sequel Ghostbusters II (1989), she discovered she was pregnant and retired from public life for a while. She gave birth to her daughter, Charlotte Simpson, on 13 April 1990, and returned to the movies as a (now skinhead) Ripley in Alien³ (1992) and a gorgeous \\\\\\\\\\\\\\"Queen Isabella of Spain\\\\\\\\\\\\\\" in 1492: Conquest of Paradise (1992), her second film with director Ridley Scott. She starred in the political comedy Dave (1993) alongside Kevin Kline, and then a Roman Polanski thriller, Death and the Maiden (1994).\\\\\\\\r\\\\\\\\n\\\\\\\\r\\\\\\\\nIn 1995, she was seen in Jeffrey (1995) and Copycat (1995). The next year, she \\\\\\\\\\\\\\"trod the boards\\\\\\\\\\\\\\" in \\\\\\\\\\\\\\"Sex and Longing\\\\\\\\\\\\\\", yet another Durang play. She hadn\\\\\\\\\\\\\\''t performed in the theater in many years before that play, her last stage performances occurring in the 1980s in \\\\\\\\\\\\\\"As You Like It\\\\\\\\\\\\\\" (1981), \\\\\\\\\\\\\\"Beyond Therapy\\\\\\\\\\\\\\" (1981), \\\\\\\\\\\\\\"The Marriage of \\\\\\\\\\\\\\''Bette and Boo\\\\\\\\\\\\\\''\\\\\\\\\\\\\\" (1985) and \\\\\\\\\\\\\\"The Merchant of Venice\\\\\\\\\\\\\\" (1986). In 1997, she was the protagonist in Grimm\\\\\\\\\\\\\\''s Snow White: A Tale of Terror (1997), The Ice Storm (1997) and Alien: Resurrection (1997). Her performance in The Ice Storm (1997) got her a BAFTA prize and another Golden Globe nod. She also gave excellent performances in O harta a lumii (1999) and the sci-fi spoof Galaxy Quest (1999). Her next comedy, Company Man (2000), wasn\\\\\\\\\\\\\\''t quite so warmly welcomed critically and financially, however. She next played a sexy con artist in Heartbreakers (2001) and had a voice role in Big Bad Love (2001). Her father died at the age of 93. Sigourney herself has recently starred in Tadpole (2000) and is planning a cinematic version of The Guys (2002), the enthralling September 11th one-act drama she played on stage on late 2001. At age 60, she played a crucial role in Avatar (2009), which became the top box-office hit of all time. The film reunited her with her Aliens - Misiune de pedeapsa (1986) director James Cameron. Her beauty, talent, and hard-work keeps the ageless actress going, and she has continued to win respect from her fans and directors.', 'sigourney_waver.jpg', 0),
(6, 'Chris', 'Evans', 'Boston, Massachusetts', 'June 13, 1981', 'USA', 'Chris Evans - not to be confused with the British DJ and wild man of the same name - began his acting career in typical fashion: performing in school productions and community theater. But it was his rapid rise to stardom that was unusual. Bitten by the acting bug in the first grade because his older sister, Carly, started performing, Evans followed suit and began appearing in school plays. From there, it was a quick jump to theater camp and later an internship for a casting office\r\n\r\na position he held one summer while living in a hole-in-the-wall in\r\nBrooklyn, New York. Once Evans made friends with a few agents on the job, it was a straight shot to television and blockbuster features.\r\n\r\nOriginally from Framingham, Massachusetts, the Evans family moved to suburban Sudbury when he was 11 years-old. While at Lincoln-Sudbury Regional High School, his obvious talent led others to lavish praise and encouragement on him, particularly his drama teacher, who cited his performance as "Leontes" in "The Winter''s Tale" as exemplary of his skill. After more school plays and regional theater, he moved to New York and attended the Lee Strasberg Theater Institute. On the advice of friends, he landed an internship at a casting office and befriended a couple of the agents he regularly communicated with - one of whom later took him on as a client. The screen - not the stage - then became his focus; Evans soon began auditioning for feature films and series television.\r\n\r\nEvans made one of his first appearances on The Fugitive (2000) (CBS, 2000-2001), a remake of the 1960s series and feature film starring Harrison Ford. In the episode "Guilt", Evans played the son of a small-town sheriff who tries to exact revenge after Dr. Kimble - incognito as a liquor store owner - refuses to sell him and his friends alcohol. After small roles in Cherry Falls (2000) and The Newcomers (2000) - two unknown low-budget features - Evans appeared in Boston Public (2000) (Fox, 2000-2004) as a murder suspect. He then appeared in his first major feature, Not Another Teen Movie (2001), a tiresome spoof on teen comedies wherein he played a jock who makes a bet that he can turn an unpopular and unkempt girl (Chyler Leigh) into prom queen.\r\n\r\nAfter filming a couple of television pilots he was confident would be successful - Just Married (2003) and Eastwick (2002) - he appeared in another listless teen comedy, The Perfect Score (2004), playing an average, ho-hum student who takes part in a plot to steal the SAT test. Hijinks naturally ensue. Then, Evans broke through to the Big Time, grabbing the lead in the kidnapping thriller, Celularul (2004), a suspenseful B movie with a cheesy gimmick - a random wrong number on his cell phone forces him into a high-stakes race to save an unknown woman''s life. Despite an unassuming performance from Evans and Kim Basinger as the damsel in distress, Celularul (2004) failed to break any box office records or please a wide majority of critics. Evans then prepared himself for super stardom when he signed on to play "Johnny Storm" (a.k.a. The Human Torch)in Fantastic Four (2005), 20th Century Fox''s long-awaited adaptation of the Marvel comic. Although the film was wildly uneven and disappointing, Evans nearly stole the show with his energetic, unfettered performance.', 'chris_evans.jpg', 0),
(7, 'Tim', 'Robbins', 'West Covina, California', '16 October 1958', 'USA', 'Born in West Covina, California, but raised in New York City, Tim Robbins is the son of former The Highwaymen singer Gil Robbins and actress Mary Robbins. Robbins studied drama at UCLA, where he graduated with honors in 1981. That same year, he formed the Actors\\'' Gang theater group, an experimental ensemble that expressed radical political observations through the European avant-garde form of theater. He started film work in television movies in 1983, but hit the big time in 1988 with his portrayal of dimwitted fastball pitcher \\''Nuke\\'' Laloosh in Bull Durham (1988). Tall with baby-faced looks, he has the ability to play naive and obtuse (Cadillac Man (1990) and The Hudsucker Proxy (1994)) or slick and shrewd (Joc de culise (1992) and Bob Roberts (1992)).', 'tim_robbins.jpg', 0),
(8, 'Morgan', 'Freeman', 'Memphis, Tennessee', '1 June 1937', 'USA', 'With an authoritative voice and calm demeanor, this ever popular American actor has grown into one of the most respected figures in modern US cinema. Born in June 1937 in Memphis, Tennessee, the young Freeman attended Los Angeles City College before serving several years in the US Air Force as a mechanic between 1955 and 1959. His first dramatic arts exposure was on the stage including appearing in an all-African American production of the exuberant musical Hello, Dolly!.\r\n\r\nThroughout the 1970s, he continued his work on stage, winning Drama Desk and Clarence Derwent Awards and receiving a Tony Award nomination for his performance in The Mighty Gents in 1978. In 1980, he won two Obie Awards, for his portrayal of Shakespearean anti-hero Coriolanus at the New York Shakespeare Festival and for his work in Mother Courage and Her Children. Freeman won another Obie in 1984 for his performance as The Messenger in the acclaimed Brooklyn Academy of Music production of Lee Breuer''s The Gospel at Colonus and, in 1985, won the Drama-Logue Award for the same role. In 1987, Freeman created the role of Hoke Coleburn in Alfred Uhry''s Pulitzer Prize-winning play Driving Miss Daisy, which brought him his fourth Obie Award. In 1990, Freeman starred as Petruchio in the New York Shakespeare Festival''s The Taming of the Shrew, opposite Tracey Ullman. Returning to the Broadway stage in 2008, Freeman starred with Frances McDormand and Peter Gallagher in Clifford Odets'' drama The Country Girl, directed by Mike Nichols.\r\n\r\nFreeman first appeared on TV screens as several characters including "Easy Reader", "Mel Mounds" and "Count Dracula" on the Children''s Television Workshop (now Sesame Workshop) show The Electric Company (1971). He then moved into feature film with another children''s adventure, Who Says I Can''t Ride a Rainbow! (1971). Next, there was a small role in the thriller Blade (1973); then he played Casca in Julius Caesar (1979) and the title role in Coriolanus (1979). Regular work was coming in for the talented Freeman and he appeared in the prison dramas Attica (1980) and Brubaker (1980), Eyewitness (1981), and portrayed the final 24 hours of slain Malcolm X in Death of a Prophet (1981). For most of the 1980s, Freeman continued to contribute decent enough performances in films that fluctuated in their quality. However, he really stood out, scoring an Oscar nomination as a merciless hoodlum in Street Smart (1987) and, then, he dazzled audiences and pulled a second Oscar nomination in the film version of Driving Miss Daisy (1989) opposite Jessica Tandy. The same year, Freeman teamed up with youthful Matthew Broderick and fiery Denzel Washington in the epic Civil War drama Glory (1989) about freed slaves being recruited to form the first all-African American fighting brigade.\r\n\r\nHis star continued to rise, and the 1990s kicked off strongly with roles in The Bonfire of the Vanities (1990), Robin Hood: Prince of Thieves (1991), and The Power of One (1992). Freeman''s next role was as gunman Ned Logan, wooed out of retirement by friend William Munny to avenge several prostitutes in the wild west town of Big Whiskey in Clint Eastwood''s de-mythologized western Necrutatorul (1992). The film was a sh and scored an acting Oscar for Gene Hackman, a directing Oscar for Eastwood, and the Oscar for best picture. In 1993, Freeman made his directorial debut on Bopha! (1993) and soon after formed his production company, Revelations Entertainment.\r\n\r\nMore strong scripts came in, and Freeman was back behind bars depicting a knowledgeable inmate (and obtaining his third Oscar nomination), befriending falsely accused banker Tim Robbins in Închisoarea îngerilor (1994). He was then back out hunting a religious serial killer in Se7en (1995), starred alongside Keanu Reeves in Chain Reaction (1996), and was pursuing another serial murderer in Kiss the Girls (1997).\r\n\r\nFurther praise followed for his role in the slave tale of Amistad (1997), he was a worried US President facing Armageddon from above in Impact nimicitor (1998), appeared in Neil LaBute''s black comedy Nurse Betty (2000), and reprised his role as Alex Cross in Along Came a Spider (2001). Now highly popular, he was much in demand with cinema audiences, and he co-starred in the terrorist drama The Sum of All Fears (2002), was a military officer in the Stephen King-inspired Dreamcatcher (2003), gave divine guidance as God to Jim Carrey in Dumnezeu pentru o zi (2003), and played a minor role in the comedy The Big Bounce (2004).\r\n\r\n2005 was a huge year for Freeman. First, he he teamed up with good friend Clint Eastwood to appear in the drama, O Fata de Milioane (2004). Freeman''s on-screen performance is simply world-class as ex-prize fighter Eddie "Scrap Iron" Dupris, who works in a run-down boxing gym alongside grizzled trainer Frankie Dunn, as the two work together to hone the skills of never-say-die female boxer Hilary Swank. Freeman received his fourth Oscar nomination and, finally, impressed the Academy''s judges enough to win the Best Supporting Actor Oscar for his performance. He also narrated Steven Spielberg''s War of the Worlds (2005) and appeared in Batman - Inceputuri (2005) as Lucius Fox, a valuable ally of Christian Bale''s Bruce Wayne/Batman for director Christopher Nolan. Freeman would reprise his role in the two sequels of the record-breaking, genre-redefining trilogy.\r\n\r\nRoles in tentpoles and indies followed; highlights include his role as a crime boss in Slevin: Nevinovat cu ghinion (2006), a second go-round as God in Evan Almighty (2007) with Steve Carell taking over for Jim Carrey, and a supporting role in Ben Affleck''s directorial debut, Disparuta fara urma (2007). He co-starred with Jack Nicholson in the breakout hit The Bucket List (2007) in 2007, and followed that up with another box-office success, Wanted (2008), then segued into the second Batman film, Cavalerul negru (2008).\r\n\r\nIn 2009, he reunited with Eastwood to star in the director''s true-life drama Neinfrant (2009), on which Freeman also served as an executive producer. For his portrayal of Nelson Mandela in the film, Freeman garnered Oscar, Golden Globe and Critics'' Choice Award nominations, and won the National Board of Review Award for Best Actor.\r\n\r\nRecently, Freeman appeared in Greu de pensionat (2010), a surprise box-office hit; he narrated the Conan Barbarul (2011) remake, starred in Rob Reiner''s The Magic of Belle Isle (2012); and capped the Batman trilogy with The Dark Knight Rises (2012). Freeman has several films upcoming, including the thriller Now You See Me: Jaful perfect (2013), under the direction of Louis Leterrier, and the science fiction actioner Oblivion. Planeta uitata (2013), in which he stars with Tom Cruise.', 'morgan_freeman.jpg', 0),
(9, 'Jonny', 'Depp', 'Owensboro, Kentucky', '9 June 1963', 'USA', 'Born John Christopher Depp in Owensboro, Kentucky, on June 9, 1963, Johnny Depp was raised in Florida. He dropped out of school at age 15 in the hopes of becoming a rock musician. He fronted a series of garage bands including The Kids, which once opened for Iggy Pop. Depp got into acting after a visit to Los Angeles, California, with his former wife, Lori Anne Allison (Lori A. Depp), who introduced him to actor Nicolas Cage. He made his film debut in A Nightmare on Elm Street (1984). In 1987 he shot to stardom when he replaced Jeff Yagher in the role of undercover cop Tommy Hanson in the popular TV series 21 Jump Street (1987).\r\n\r\nIn 1990, after numerous roles in teen-oriented films, his first of a handful of great collaborations with director Tim Burton came about when Depp played the title role in Edward Scissorhands (1990). Following the film''s success, Depp carved a niche for himself as a serious, somewhat dark, idiosyncratic performer, consistently selecting roles that surprised critics and audiences alike. He continued to gain critical acclaim and increasing popularity by appearing in many features before re-joining with Burton in the lead role of Ed Wood (1994). In 1997 he played an undercover FBI agent in the fact-based film Donnie Brasco (1997), opposite Al Pacino; in 1998 he appeared in Fear and Loathing in Las Vegas (1998), directed by Terry Gilliam; and then, in 1999, he appeared in the sci-fi/horror film The Astronaut''s Wife (1999). The same year he teamed up again with Burton in Sleepy Hollow (1999), brilliantly portraying Ichabod Crane.\r\n\r\nDepp has played many characters in his career, including another fact-based one, Insp. Fred Abberline in Din iad (2001). He stole the show from screen greats such as Antonio Banderas in the finale to Robert Rodriguez''s "mariachi" trilogy, Once Upon a Time in Mexico (2003). In that same year he starred in the marvelous family blockbuster Pirates of the Caribbean: The Curse of the Black Pearl (2003), playing a character that only the likes of Depp could pull off: the charming, conniving and roguish Capt. Jack Sparrow. Now Depp is collaborating again with Burton in a screen adaptation of Roald Dahl''s novel, Charlie and the Chocolate Factory (2005).\r\n\r\nOff-screen, Depp has dated several female celebrities, and has been engaged to Sherilyn Fenn, Jennifer Grey, Winona Ryder and Kate Moss. He was married to Lori Anne Allison in 1983 but they divorced her in 1985. Depp has two children with French singer-actress Vanessa Paradis: Lily-Rose Melody, born in 1999 and Jack, born in 2002.\r\n- IMDb Mini Biography By: mikedavies86\r\n\r\nJohnny Depp is perhaps one of the most versatile actors of his day and age in Hollywood, who has recuperated his image greatly since his portrayal of Captain Jack Sparrow in the acclaimed Pirates of the Caribbean: The Curse of the Black Pearl (2003), with a supporting cast of Orlando Bloom, Keira Knightley, and Geoffrey Rush.\r\n\r\nThough highly successful now, Depp''s early life, strangely, was as a rebel, and he took to vandalism and narcotics. He dropped out of school when he was 15, and he fronted a series of music-garage bands, including one named The Kids. However, it was when he married Lori Anne Allison (Lori A. Depp) that he took up the job of being a ballpoint-pen salesman to support himself and his wife. A visit to Los Angeles, California, with his wife, however, happened to be a blessing in disguise, when he met up with actor Nicolas Cage, who advised him to turn to acting, which culminated in Depp''s film debut in the low-budget horror film, A Nightmare on Elm Street (1984), where he played a teenager who falls prey to dream-stalking demon Freddy Krueger. Three years later, Depp achieved fame as police cop Tom Hanson in the series 21 Jump Street (1987) (1987-90), and in 1990, he was firmly established as a leading Hollywood actor with the Tim Burton movie Edward Scissorhands (1990), where he played a sad-faced, tragic hero who has scissors for hands.\r\n\r\nFrom then on, Depp was selective of his choice of roles in movies, and he more often than not played dark, sinister characters on-screen. He played an undercover FBI agent in Donnie Brasco (1997), in which he co-starred with Al Pacino; a druggie in Fear and Loathing in Las Vegas (1998); and in two more Tim Burton ventures, Ed Wood (1994) and Sleepy Hollow (1999), with Christina Ricci and Casper Van Dien. He filmed a fifth Tim Burton film, Corpse Bride (2005), as well as being committed for another Tim Burton production, where he plays Willy Wonka in the upcoming Charlie and the Chocolate Factory (2005), based on the classic children''s novel by Roald Dahl.\r\n\r\nDuring his career, Depp has, unfortunately, gotten himself under bad public scrutiny. He was accused of selling drugs at his own club, The Viper Room, in regard to the legendary celebrity, River Phoenix, who died outside the club due to drug overdose in 1993. The following year, Depp was arrested for smashing and trashing a New York suite. And, in 1999, he was arrested in London for being in a fight with paparazzi outside a restaurant.\r\n\r\nAlthough he gained popularity since the success of Edward Scissorhands (1990), Depp wasn''t hugely famous for many years until his portrayal of the suave, charming Captain Jack Sparrow in Pirates of the Caribbean: The Curse of the Black Pearl (2003) in 2003. With the film''s enormous success, it has opened several doors for his career and even included an Oscar nomination. He appeared as the central character in the Stephen King-based movie, Secret Window (2004); as the kind-hearted novelist James Barrie in the factually-based Finding Neverland (2004), where he co-starred with Kate Winslet; and most recently as Rochester in the British film, The Libertine (2004).', 'jonny_depp.jpg', 0),
(10, 'Rebecca', 'Hall', 'London', '3 May 1982', 'England, UK', 'She is the daughter of Peter Hall and Maria Ewing.\r\nAttended Roedean School in East Sussex, where she was head girl. Then studied English at Cambridge University, but dropped out after her second year.\r\nYounger half sister of theatre director Edward Hall, theatre set designer Lucy Hall, producer Christopher Hall and Jennifer Caron Hall.\r\nShe contributed a doodle for Epilepsy Action''s National Doodle Day on Friday 23 February 2007.\r\nHer favorite film is Woody Allen''s 1979 movie, Manhattan (1979).\r\nFor her professional stage debut in "Mrs Warren''s Profession" (dir. Peter Hall), she won the 2002 Sunday Times/ National Theatre ''Ian Charleson'' Award which recognises performances in classical roles for actors and actresses under 30 in Britain. She was nominated for the same award in 2004 for her performance in "As You Like It" (dir. Peter Hall).\r\nShe is the daughter of English theater director Peter Hall (who founded the Royal Shakespeare Company) and American opera singer Maria Ewing. Peter Hall is a white Englishman. Maria Ewing''s paternal grandparents were both of part African ancestry. Maria''s father, Norman Isaac Ewing, also had Scottish, and possible Sioux Native American, roots. Maria''s mother, Hermina Maria Veraar, who was caucasian, was Dutch.\r\nAttended Cumnor House School in East Sussex from age 9 to 13.\r\nHer agent paid for the fares for their flight to New York to audition for Orasul (2010) because she did not have the money.\r\nStepsister-in-law of Issy Van Randwyck.\r\nCurrently in rehearsal for a National Theatre production of William Shakespeare''s "Twelfth Night", directed by her father, Peter Hall. [December 2010]\r\nRebecca holds Dual Citizenship for the United States and the UK.', 'rebecca_hall.jpg', 0),
(11, 'Paul', 'Bettany', 'Harlesden, London', '27 May 1971', 'England, UK', 'Paul Bettany was born into a theatre family. His father, Thane Bettany, is still an actor but his mother, Anne Kettle, has retired from acting. He has an older sister who is a writer and a mother. His maternal grandmother, Olga Gwynne (her maiden and stage name), was a successful actress, while his maternal grandfather, Lesley Kettle, was a musician and promoter. He was brought up in North West London and, after the age of 9, in Hertfordshire (Brookmans Park). Immediately after finishing at Drama Centre, he went into the West End to join the cast of "An Inspector Calls", though when asked to go on tour with this play, he chose to stay in England.', 'paul_bettany.jpg', 0),
(12, 'Zac', 'Efron', 'San Luis Obispo, California', '18 October 1987', 'USA', 'Zachary David Alexander Efron was born on October 18, 1987, in San Luis Obispo, California. He is the son of Starla Baskett, a former secretary, and David Efron, an electrical engineer. He has a brother, Dylan. His surname, "Efron", means "lark" (a bird) in Hebrew, and comes from Zac''s Ashkenazi Jewish paternal grandfather. Zac''s other recent ancestry is English, German, Irish, and Scottish. Zac was raised in Arroyo Grande. He took his first step toward acting at the age of eleven, after his parents noticed his singing ability. Singing and acting lessons soon led to an appearance in a production of "Gypsy" that ran 90 performances, and he was hooked.\r\n\r\nAfter appearing on-stage in "Peter Pan", "Auntie Mame", "Little Shop of Horrors" and "The Music Man", guest parts quickly followed on television series, including Firefly (2002), ER (1994), CSI: Miami (2002), NCIS: Naval Criminal Investigative Service (2003), and The Guardian (2001). After guest-starring in several episodes of Summerland (2004), Zac joined the regular cast as girl-crazy Cameron Bale. He also starred in several pilots, such as The Big Wide World of Carl Laemke (2003) and Triple Play (2004), and played an autistic child in the television movie Miracle Run (2004), alongside Mary-Louise Parker and Aidan Quinn. He graduated Arroyo Grande High School in June 2006.\r\n\r\nEfron came to fame for starring in the Disney Channel original film High School Musical (2006), for which he won the Teen Choice Award for Breakout Star. He returned to the role of Troy Bolton in High School Musical 2 (2007), which broke cable TV records with 17.5 million viewers.\r\n\r\nHe played title roles of the fantasy romance Charlie St. Cloud (2010) and the comedy 17 Again (2009), both from director Burr Steers, and as the lovable Link Larkin in 2007''s smash hit musical Hairspray: Intrigi de culise (2007), directed by Adam Shankman. As part of the all-star cast he shared a Critics Choice Award for Best Acting Ensemble, the 2007 Hollywood Film Festival Award for Ensemble of the Year, and was honored with a Screen Actors Guild Award® nomination for Outstanding Motion Picture Cast. In addition, he won an MTV Movie Award for Breakthrough Performance.\r\n\r\nEfron also starred in Richard Linklater''s Me and Orson Welles (2008), an adaptation of the novel by Robert Kaplow, which premiered to rave reviews at the 2008 Toronto Film Festival. That same year, he starred in Kenny Ortega''s High School Musical 3: Senior Year (2008), which set a box office record for the highest grossing opening weekend for a musical.\r\n\r\nIn 2012, Efron took the lead in The Lucky One (2012), a film adaptation of the Nicholas Sparks novel, playing a marine who returns to North Carolina after serving in Iraq in search for the unknown woman he believes was his good luck charm during the war. He also lent his voice to the animated feature Dr. Seuss'' The Lorax (2012), and co-starred in Lee Daniels'' thriller The Paperboy (2012), alongside Nicole Kidman, John Cusack, Matthew McConaughey and Scott Glenn, as well as Josh Radnor''s Liberal Arts (2012), which premiered to rave reviews at the Sundance Film Festival.\r\n\r\nEfron''s favorite sports include golf, skiing, rock climbing, and snowboarding. He added surfing after spending days on the beach for "Summerland." He played the piano at home. He has also fixed up two cars in his spare time, a Delorean and ''65 Mustang convertible, both treasured hand-me-downs from his even-more-treasured grandfather.', 'zack_effron.jpg', 0),
(13, 'Rose', 'Byrne', 'Balmain, Sydney, New South Wales,', '24 July 1979', 'Australia', 'Rose was born in Sydney, Australia. She landed her first role in a movie, Dallas Doll (1994), when she was 15 years old.\r\n\r\nSince then, Rose has appeared in a variety of Australian televisions shows including Heartbreak High (1994), Echo Point (1995), and the film Two Hands (1999) alongside Heath Ledger. After this, she appeared in various movies like The Date (1999), My Mother Frank (2000), and Clara Law''s The Goddess of 1967 (2000) for which she obtained the Female Volpi Cup at the Venice Festival in 2000.\r\n\r\nHer first experience on a big-budget movie came when she played handmaiden, Dormé, to Natalie Portman, Padmé Amidala, in Star Wars: Episode II - Attack of the Clones (2002). In 2003, she starred, coincidentally, as Rose Mortmain in the adaptation of Dodie Smith''s I Capture the Castle (2003). In 2004, she acted in Carari intortocheate (2004) with Diane Kruger and Josh Hartnett. Here, she heard Wolfgang Petersen was looking for an actress for Briseis in his next movie Troia (2004) with Brad Pitt, she got the part and was recognised as one of the most promising actresses in Hollywood.\r\n\r\nAfter Troia (2004), she played Edith in a TV adaptation of Casanova (2005). In September 2005, she started to act in Sunshine (2007), a Danny Boyle movie, where she plays the pilot in a space mission.', 'rose_byrne.jpg', 0),
(14, 'Dave', 'Franco', 'Palo Alto, California', '12 June 1985', 'USA', 'Dave Franco was born in Palo Alto, California. His mother, Betsy, is Jewish, and his father, Doug Franco, was of Portuguese and Swedish descent. He has two older brothers, actor James Franco and Tom. Dave made his first television appearance at the age of 21, in 2006, in an episode of 7th Heaven (1996). A string of high-profile TV work followed, interspersed with roles in some moderately successful movies, including Charlie St. Cloud (2010) and Fright Night (2011), and he came to bigger prominence when he played Eric Molson in the hit movie version of the cult TV series 21 Jump Street - O adresa de pomina (2012). He subsequently co-starred in the zombie romance Iubitul meu e zombi (2013) and the thriller Now You See Me: Jaful perfect (2013), and provided a voice role for Marea aventura Lego (2014). His upcoming films include Vecini de cosmar (2014), O alta adresa de pomina (2014), and Business or Pleasure (2015).', 'dave_franco.jpg', 0),
(15, 'Seth', 'Rogen', 'Vancouver, British Columbia', '15 April 1982', 'Canada', 'A talented actor, comedian and writer, Seth Rogen has come a long way from doing stand-up comedy as a teen. Rogen was born in Vancouver, British Columbia, to Mark and Sandy Rogen. He attended Vancouver Talmud Torah Elementary School and Point Grey Secondary School (although he dropped out of high school to move to Los Angeles) and was known for the stand-up comedy he performed at Camp Miriam, a Habonim Dror camp. At 16, Rogan came in second place in the 1998 Vancouver Amateur Comedy Contest.\r\n\r\nSoon after that win he landed his first role in Judd Apatow''s short-lived but well regarded TV series Freaks and Geeks (1999), taking on the role of Ken Miller. Though the show only lasted one season, it was the launching pad for many careers, including Rogen, Apatow, James Franco, and Jason Segel. This early work sharpened Rogen''s keen improvisational skills, which he''s used on many projects since.\r\n\r\nFollowing Freaks and Geeks (1999), he participated in a few unsuccessful television projects, and then joined the American television version of Da Ali G Show (2003) as a writer during its second and last season, along with his childhood friend and writing partner Evan Goldberg. The writing team received an Emmy nomination. As a huge fan of the first season, Rogen was thrilled to get the chance to work with Sacha Baron Cohen.\r\n\r\nContinuing his work with Apatow, he joined the cast of Apatow''s debut film The 40 Year Old Virgin (2005) and is credited as co-producer. After that he took the lead in Knocked Up (2007), Apatow''s second movie and a huge success. He''s since been a frequent collaborator with Apatow, in projects such as Superbad (2007), Pineapple Express (2008) and Tipi simpatici (2009). He co-wrote Superbad (2007), with Goldberg; the pair started the project when they were teens. They won the Canadian Comedy Award for Best Writing in a Film in 2008. They later wrote Pineapple Express (2008) and Viespea verde 3D (2011), also starring Rogen.\r\n\r\nA talented voice artist, Rogen is in the animated films Horton Hears a Who! (2008), Kung Fu Panda (2008), and Monstri contra extraterestri (2009), and has voiced characters for Familia Simpson (1989) and American Dad! (2005).\r\n\r\nRogen was named the Canadian Comedy Person of the Year by the Canadian Comedy Awards in both 2008 and 2009.\r\n\r\nRogen lives in Los Angeles with Lauren Miller, whom he met in 2004. They became engaged in September 2010 and married in October 2011.', 'seth_rogen.jpg', 0);
INSERT INTO `actor` (`id`, `first_name`, `last_name`, `birth_place`, `birth_date`, `country`, `biography`, `picture`, `views`) VALUES
(16, 'Ben', 'Stiller', 'New York City, New York', '30 November 1965', 'USA', 'Ben Stiller was born on November 30, 1965, in New York, New York to legendary comedians Jerry Stiller and Anne Meara. It''s not surprising that Ben Stiller has followed in his family''s footsteps. Ben''s parents made no real effort to keep their son away from the Hollywood lifestyle and he grew up among the stars, wondering just why his parents were so popular. At a young age, he and his sister Amy Stiller would perform plays at home, wearing Amy''s tights to perform Shakespeare. Ben also picked up an interest in being on the other side of the camera and, at age 10, began shooting films on his Super 8 camera. The plots were always simple: someone would pick on the shy, awkward Stiller...and then he would always get his revenge. This desire for revenge on the popular, good-looking people may have motivated his teen-angst opus Reality Bites (1994) later in his career. He both directed and performed in the film, which costarred Winona Ryder and Ethan Hawke.\r\n\r\nBefore he even got his start in Hollywood, Ben put in several consistently solid years in the theater. After dropping out of UCLA, he performed in the Tony Award winner, "The House of Blue Leaves". While working on the play, Stiller shot a short spoof of Culoarea banilor (1986) starring him (in the Tom Cruise role) and his American Playhouse: The House of Blue Leaves (1987) costar John Mahoney (in the Paul Newman role). The short film was so funny that Lorne Michaels purchased it and aired it on Saturday Night Live (1975). This led to Ben spending a year on the show in 1989.\r\n\r\nBen made his big screen debut in Steven Spielberg''s Empire of the Sun (1987) in 1987. Demonstrating early on the multifaceted tone his career would take, he soon stepped behind the camera to direct Back to Brooklyn for MTV. The network was impressed and gave Stiller his own show, The Ben Stiller Show (1992). He recruited fellow offbeat comedians Janeane Garofalo and Andy Dick and created a bitingly satirical show. MTV ended up passing on it, but it was picked up by Fox. Unfortunately, the show was a ratings miss. Stiller was soon out of work, although he did have the satisfaction of picking up an Emmy for the show after its cancellation.\r\n\r\nFor a while, Ben had to settle for guest appearance work. While he was doing this, he saved up his cash and in the end was able to scrape enough together to make Reality Bites (1994), now a cult classic which is looked upon favorably by the generation it depicted. Ben continued to work steadily for a time, particularly in independent productions where he was more at ease. However, he never quite managed to catch a big break. His first big budget directing job was Jim Carrey''s The Cable Guy (1996). Although many critics were impressed, Jim Carrey''s fans were not.\r\n\r\nIn 1998, There''s Something About Mary (1998) had propelled Ben into the mainstream spotlight. With his wince-inducing turn in the Farrelly brothers'' gross-out film, Ben really "struck a nerve" with mainstream America. In recent years, Ben has starred in such hit movies as Preotul, rabinul si fata (2000) and Meet the Parents (2000). Ben excels at cerebral comedy, but he knows how to get down and lowbrow when he needs to, making him one of America''s currently most popular performers.', 'ben_stiller.jpg', 0),
(17, 'Kristen', 'Wiig', 'Canandaigua, New York', '22 August 1973', 'USA', 'Kristen Carroll Wiig was born on August 22, 1973 in Canandaigua, New York, to Laurie and Jon J. Wiig. The family moved to Lancaster, Pennsylvania, before settling in the Rochester, New York. When Wiig was 9 years old, her parents divorced and she lived with her mother and older brother Erik. \r\n\r\nAfter graduating from Brighton High School in Rochester, Wiig attended the University of Arizona as an art student. She took her first acting class, as an elective, and was soon encouraged by her teacher to pursue acting. Years later, she moved to Los Angeles and Wiig worked as a main company member of the Los Angeles-based improv and sketch-comedy troupe The Groundlings. As a Groundlings alumna, she joins the ranks of such SNL cast mates as Maya Rudolph, Will Ferrell, Phil Hartman, and Jon Lovitz. \r\n\r\nWiig made her big-screen debut to universal high praise as Katherine Heigl''s passive-aggressive boss in Judd Apatow''s smash-hit comedy Knocked Up (2007). Additional film credits include Drew Barrymore''s directorial debut, Whip It (2009), starring Ellen Page; Greg Mottola''s Adventureland (2009), with Ryan Reynolds, Kristen Stewart and Jesse Eisenberg; David Koepp''s Ghost Town (2008), with Ricky Gervais; and Jake Kasdan''s Walk Hard: The Dewey Cox Story (2007), another Apatow-produced film, in which she starred opposite John C. Reilly. She has also guest-starred on the Emmy-winning NBC series 30 Rock (2006), the HBO series Bored to Death (2009), with Jason Schwartzman, and Flight of the Conchords (2007).\r\n\r\nWiig joined the cast of Saturday Night Live (1975) in 2008, and was known for playing such memorable characters as the excitable Target clerk, Lawrence Welk singer Doonese, the hilarious one-upper Penelope, House Speaker Nancy Pelosi, and Suze Orman, among others. Wiig earned two Emmy nominations for Outstanding Supporting Actress in a Comedy Series for her work on the show. She left the show in the spring of 2012.\r\n\r\nIn 2011, Wiig co-wrote and starred in Bridesmaids (2011), along with Melissa McCarthy, Maya Rudolph, and Rose Byrne. The film was a box office hit and won several awards, plus earned two Oscar nominations (Best Supporting Actress and Best Original Screenplay), and two Golden Globes nominations (Best Motion Picture - Comedy or Musical and Best Actress). \r\n\r\nWiig also appeared in such notable films as Greg Mottola''s Paul. Un extraterestru fugit de-acasa (2011), opposite Simon Pegg and Nick Frost; Andrew Jarecki''s All Good Things (2010), opposite Ryan Gosling, Kirsten Dunst and Frank Langella; DreamWorks Animation''s Cum Sa Iti Dresezi Dragonul (2010), with Gerard Butler and Jay Baruchel; the Universal Pictures'' animated feature film Sunt un mic ticalos (2010), starring Steve Carell and Jason Segel; and Jennifer Westfeldt''s Friends with Kids (2011), opposite Jon Hamm, Megan Fox, Adam Scott, Maya Rudolph and Westfeldt.', 'kristen_wiig.jpg', 0),
(18, 'Adam', 'Scott', 'Santa Cruz, California', '3 April 1973', 'USA', 'Adam Scott was born on April 3, 1973 in Santa Cruz, California, USA as Adam Paul Scott. He is an actor and producer, known for Step Brothers (2008), Viata secreta a lui Walter Mitty (2013) and The Aviator (2004). He has been married to Naomi Scott since 2005. They have two children.', 'adam_scott.jpg', 0),
(19, 'Francois', 'Cluzet', 'Paris', '21 September 1955', 'France', 'François Cluzet was born on September 21, 1955 in Paris, France. He is an actor, known for Invincibilii (2011), Ne le dis à personne (2006) and Les petits mouchoirs (2010).\r\nHas a son, Paul Cluzet, with actress Marie Trintignant.\r\nHas four children: Blanche, Paul, Joseph and Marguerite.\r\nAfter leaving high school at the age of 18, he attended acting lessons at Cours Simon and Cours de Périmony et Cochet.\r\nGrew up in Paris, where his father was a merchant.\r\nHas two children with Valérie Bonneton: Joseph (b. 2001) and Marguerite (b. July 2006).\r\nHas a look-alike puppet in the French show Les guignols de l''info (1988).', 'francois_cluzet.jpg', 0),
(20, 'Omar', 'Sy', 'Trappes, Yvelines', '20 January 1978', 'France', 'Omar Sy was born on January 20, 1978 in Trappes, Yvelines, France. He is an actor and writer, known for Invincibilii (2011), Micmacs à tire-larigot (2009) and L''écume des jours (2013). He has been married to Hélène since July 6, 2007. They have four children.', 'omar_sy.jpg', 0),
(21, 'Frank', 'Langella', 'Bayonne, New Jersey', '1 January 1938', 'USA', 'A stage and screen actor of extreme versatility, Frank Langella won acclaim on the New York stage in "Seascape" and followed it up with the title role in the Edward Gorey production of "Dracula". He repeated the role for the screen in Dracula (1979) and became an international star. Over the years, he has done occasional films but prefers to concentrate on his first love, the legitimate theatre. His stage performance ranged from Strindberg drama ("The Father") to Noel Coward comedy ("Present Laughter"). He also appeared in several productions for the New York Shakespeare festival.', 'frank_langella.jpg', 0),
(22, 'James', 'Marsden', 'Stillwater, Oklahoma', '18 September 1973', 'USA', 'James Paul Marsden, or better known as just James Marsden, was born on September 18, 1973, in Stillwater, Oklahoma, USA. His father, a distinguished Professor of Animal Sciences & Industry at Kansas State University and his mother, a nutritionist, divorced when he was just nine years old. James grew up with his four other siblings, sisters, Jennifer and Elizabeth, and brothers, Jeff and Robert.\r\n\r\nDuring his teen years, he attended Putnam City North High School which was located in Oklahoma City. After graduating in 1991, he attended Oklahoma State University and studied Broadcast Journalism. While in university, he became a member of the Delta Tau Delta fraternity. It was when he was vacationing with his family in Hawaii, he met actor Kirk Cameron, and his actress sister, Candace Cameron Bure. They eventually invited James to visit them in Los Angeles. After studying in Oklahoma State for over a year and appearing in his college production, "Bye Bye Birdie", he left school and moved to Los Angeles to pursue his interest in acting.\r\n\r\nJames got his first job on the pilot episode of Dadaca (1993) as Eddie, who was Margaret Sheffield''s boyfriend. He then became part of the Canadian television series, Boogies Diner (1994), which aired for one season. After that series ended, he got a brief role as the original Griffin on Fox''s Pe cont propriu (1994). His first big break came when he became the lead on the short-lived ABC series, Second Noah (1996). Although the show didn''t last long, the young actor received enough exposure from the public and even managed to win the hearts of fellow teenage girls.\r\n\r\nIn 1996, he attended an audition for a movie titled Primal Fear (1996) but unfortunately lost that role to Edward Norton. Two years later, he was offered a lead role in 54 (1998), which he turned down. The role later went to another actor, Ryan Phillippe. Audiences noticed that James'' star power increased when he starred in David Nutter''s Disturbing Behavior (1998), alongside Katie Holmes and Nick Stahl, which had mixed reviews, but mostly positive ones.\r\n\r\nHis role in the television series as Glenn Foy in Ally McBeal (1997), is probably one of his biggest achievement to date. He became one of the main cast members during the first half of season 5, where he showcased his singing abilities. It was in that show where he was able to grab the attention of audiences from different backgrounds.\r\n\r\nThe 5'' 10" star later played Lon Hammon Jr. in the romantic movie, Jurnalul (2004), which was based on a novel by Nicholas Sparks of the same name. His movies, The Alibi (2006) and 10th & Wolf (2006) was also released around the world to audiences in the year 2006.\r\n\r\nOne of his most memorable roles to fans is his role as Cyclops in the X-Men (2000) movie franchise. The movie was well accepted by audiences and critics, which eventually made James one of the hottest stars since it was released. He was among the actors who starred in all three of the X-Men movies. James had the honor of working alongside Patrick Stewart, Famke Janssen and Hugh Jackman in the film. However, not many people know that he actually had to wear lifts for most of his scenes in the X-men movies, because his character Cyclops is supposed to be 6" 3" compared to a 5'' 3" Wolverine. In reality, he is actually under 6'' 0", shorter than Famke Janssen who plays his love interest, Jean Grey, and even shorter than Hugh Jackman who played Wolverine.\r\n\r\nIn the year 2006, he had the opportunity to play the role of Richard White in the highly anticipated movie, Superman Returns (2006), which coincidentally was directed by Bryan Singer, the same guy who directed previous X-Men installments. Although he appeared in X-Men: The Last Stand (2006), the third installment of the X-Men franchise, many would notice that he in fact had more screen time in ''Superman Returns'', as Lois Lane''s long awaiting fiancé who had to accept the fact that his fiancée is in love with the man of steel. James earned great reviews from that movie, which led to him getting more movie roles.\r\n\r\nIn 2007, James played Corny Collins in the film Hairspray: Intrigi de culise (2007), an adaption of the Broadway musical based on John Waters movie, Hairspray (1988). He joined a star-studded cast, starring alongside top names such as John Travolta, Queen Latifah and Michelle Pfeiffer. James not only acted in that movie, but also sang two of the film''s songs, "The Nicest Kids In Town", and "Hairspray". Being part of Hairspray catapulted James to a different level of stardom as audiences got to see another side of him.\r\n\r\nHis next role was in the Disney movie, Magie în Manhattan (2007), playing Prince Edward, where he acted alongside Amy Adams, Susan Sarandon and Patrick Dempsey. Once again, James had the opportunity to sing in two songs from the movie, "True Love''s Kiss" and "That''s Amore". Magie în Manhattan (2007) appealed to not only older audiences but also to those who were fans of Disney''s network productions. Following his huge success in the years 2006 and 2007, James played the male lead role in the romantic comedy, 27 Dresses (2008), opposite actress Katherine Heigl in 2008. The movie did pretty well in the box office, earning a gross revenue of over $159 million, which exceeded the expectations of crew members especially since it was under a $30 million budget.\r\n\r\nThe year 2009 looks like it will be another great year for James as he has been signed to play the male lead again, in the upcoming horror film, The Box (2009), based on the 1970 short story "Button, Button" by author Richard Matheson. James will be starring opposite Cameron Diaz in the movie. James also managed to get a role in Nailed, an upcoming politically-influenced romantic comedy, where he plays the role of Scott. The movie which was directed by David O. Russell was filmed in Columbia, South Carolina, USA.\r\n\r\nJames is married to Lisa Linde, an actress known from her role in Zile din viata noastra (1965). Lisa is also the daughter of legendary country music songwriter, Dennis Linde. The couple wed in July 22, 2000 and have a son, Jack Holden who was born on February 1, 2001, and daughter, Mary James, who was born on August 10, 2005.\r\n\r\nMany would assume that with all this success achieved by James at this age, he would be somewhat high-headed but James mentioned that despite all the attention he''s getting from the public eye, he tries to keep himself as grounded as possible. He even admits that he flies coach instead of first class while traveling with his family. In an interview he mentioned that he believes he has a certain responsibility to let his children know that he isn''t special because of what he does, but who he is as a person. With a great humble attitude and a bright future ahead of him, there''s definitely more to expect from this Oklahoma native.', 'james_marsden.jpg', 0),
(23, 'Iko', 'Uwais', 'Uwais Qorny', '12 February 1983', 'Indonesia', 'Born in Jakarta, Indonesia, Iko Uwais has been learning Indonesian traditional martial arts, Silat, since he was 10 years old. He became National Champion in 2005 in Silat Demonstration category. Iko''s talent as a martial arts actor was discovered by Welsh film Director, Gareth Evans, who visited Iko''s Silat school for a documentary in 2007. Evans then asked Iko to quit his daytime job as a driver in a telecommunications company and join Evans'' movie production company as the leading actor in his movies.', 'iko_uwais.jpg', 0),
(24, 'Joe', 'Taslim', 'Palembang', '23 June 1981', 'Indonesia', 'Johannes Taslim or Joe Taslim (born 23 June 1981) is an Indonesian model, actor, and former Judo athlete. He became well known in the 2012 action film The Raid: Redemption.\r\n\r\nEarly life (sport career) Taslim was exposed to martial arts at an early age. His martial arts training includes Wushu, Judo, Taekwondo, and Pencak Silat. However, he found his passion in Judo and this led to his career as a professional Judo athlete. He won several gold medals in national championships, a gold medal at the 1999 South East Asia Judo championships, and a silver medal at the 2007 Asean Games. Taslim was a member of Indonesia Judo national team from 1997 to 2009, when an injury forced him to retire\r\n\r\nActor Career Taslim is active as a model and actor, appearing in magazines, TV commercials, and several Indonesian feature films. In 2010, Taslim won the role of Jaka, a sergeant in a special police squad, in the award-winning The Raid: Redemption, after a series of impressive fight auditions and reading.Following The Raid, Taslim took part in HBO Asia''s first action horror, Dead Mine, which had a theatrical release in selected Asian territories in September 2012, followed by exclusive television premieres across the HBO Asia network.\r\n\r\nIn July 2012, Variety reported that Taslim had joined the cast of the 2013 feature film Fast Six. Taslim will play the villainous Jah, a cold-blooded killer who uses his martial arts to fight the film''s protagonists, Dominic Toretto (Vin Diesel) and Brian O''Conner (Paul Walker) In May 2013, it is reported that Taslim would be playing in The Night Comes For Us.', 'joe_taslim.jpg', 0),
(25, 'Adam', 'O''Brian', 'Swansea, Wales', '21 August 1989', 'England, UK', 'Adam O''Brian''s first film, the multi-award winning ''The Imposter'', in which he starred as Frederic Bourdin, premiered in competition at the Sundance Film Festival. It went on to win two British Independent Film Awards, was shortlisted for an Academy Award, and was also won a BAFTA.\r\n\r\nAs a stage actor Adam has performed in a number of highly respected theatres, including Shakespeare''s Globe, The Royal Court, Soho Theatre, The Music Room at Buckingham Palace, The Beijing National Stadium, West Yorkshire Playhouse, Theatre by the Lake and The National Chinese Centre of Performing Arts.\r\n\r\nAdam trained at the Royal Welsh College of Music and Drama, and before that trained as a member of the National Youth Theatre.', 'adam_o''brian.jpg', 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `actor_film`
--

CREATE TABLE IF NOT EXISTS `actor_film` (
  `actor_id` int(11) NOT NULL,
  `filme_id` int(11) NOT NULL,
  `aka` varchar(32) NOT NULL,
  PRIMARY KEY (`actor_id`,`filme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Salvarea datelor din tabel `actor_film`
--

INSERT INTO `actor_film` (`actor_id`, `filme_id`, `aka`) VALUES
(3, 1, 'Jake Sully'),
(5, 1, '0'),
(6, 3, '0'),
(7, 0, '0'),
(8, 0, '0'),
(9, 5, '0'),
(10, 5, '0'),
(11, 5, '0'),
(12, 6, '0'),
(13, 6, '0'),
(14, 6, '0'),
(15, 6, '0'),
(16, 7, '0'),
(17, 7, '0'),
(18, 7, '0'),
(19, 8, '0'),
(20, 8, '0'),
(21, 9, '0'),
(22, 9, '0'),
(23, 10, '0'),
(24, 10, '0');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `cart`
--

CREATE TABLE IF NOT EXISTS `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `filme_id` int(11) NOT NULL,
  `film_name` varchar(32) NOT NULL,
  `session_id` varchar(32) NOT NULL,
  `qty` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Salvarea datelor din tabel `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `filme_id`, `film_name`, `session_id`, `qty`) VALUES
(22, 0, 8, 'Intouchables', 'r6s923at4c21epr4nnv8de1uo6', 2);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  `regizor_id` int(11) NOT NULL,
  `actor_id` int(11) NOT NULL,
  `author` varchar(100) NOT NULL,
  `comment` text NOT NULL,
  `add_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Salvarea datelor din tabel `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `film_id`, `regizor_id`, `actor_id`, `author`, `comment`, `add_date`) VALUES
(1, 59, 5, 0, 0, 'Valimareanu', 'Am vazut trailer-ul si pot spune ca este grozav.\r\nedited by Valimareanu', '2014-05-12 20:25:59'),
(7, 0, 5, 0, 0, 'Cosmin', 'Urmatorul Matrix??? Ramane de vazut', '2014-05-12 20:10:45'),
(8, 59, 0, 0, 23, 'Valimareanu', 'Such a young and talented actor', '2014-04-29 18:07:18'),
(11, 59, 10, 0, 0, 'Valimareanu', 'So cool!!', '2014-05-12 20:51:46');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `filme`
--

CREATE TABLE IF NOT EXISTS `filme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `movie_date` varchar(100) NOT NULL,
  `movie_year` int(4) NOT NULL,
  `add_date` datetime NOT NULL,
  `sinopsis` text NOT NULL,
  `picture` varchar(255) NOT NULL,
  `stoc` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `id_gen` varchar(32) NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `views` int(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_year` (`movie_year`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Salvarea datelor din tabel `filme`
--

INSERT INTO `filme` (`id`, `name`, `movie_date`, `movie_year`, `add_date`, `sinopsis`, `picture`, `stoc`, `price`, `id_gen`, `visible`, `views`) VALUES
(1, 'Avatar', '25-03-2014', 2014, '2014-03-29 00:00:00', 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.', 'avatar.jpg', 20, 19.95, '1,2,5', 1, 31),
(2, 'American Horror Story', '10-03-2014', 2014, '2014-03-29 00:00:00', 'An anthology series that centers on different characters and locations, including a haunted house, an insane asylum, a witch coven, and a carnival.', 'ahs.jpg', 2, 99.9, '3,5,7', 1, 20),
(3, 'Captain America: The Winter Soldier', '04-04-2014', 2014, '2003-04-03 00:00:00', 'Steve Rogers struggles to embrace his role\r\n	 in the modern world and battles a new threat from old history: the Soviet agent known as the Winter Soldier.', 'captain_america.jpg', 10, 19.99, '1,3,16', 1, 16),
(4, '10.000 B.C.', '07-03-2008', 2014, '2014-04-08 19:51:39', 'A prehistoric epic that follows a young mammoth hunter\\''s journey through uncharted territory to secure the future of his tribe.', '10.000.jpg', 20, 20, '1,3,8', 1, 32),
(5, 'Transcendence', '25-06-2014', 2014, '2014-04-23 14:35:52', 'As Dr. Will Caster works toward his goal of creating an omniscient, sentient machine, a radical anti-technology organization fights to prevent him from establishing a world where computers can transcend the abilities of the human brain.', 'transcendence.jpg', 20, 20, '1,8,16', 1, 235),
(6, 'Neighbors', '08-03-2014', 2014, '2014-04-25 19:42:22', 'A couple with a newborn baby face unexpected difficulties after they are forced to live next to a fraternity house.', 'neighbors.jpg', 20, 20, '5', 1, 14),
(7, 'The Secret Life of Walter Mitty', '13-11-2013', 2013, '2014-04-25 19:59:29', 'A day-dreamer escapes his anonymous life by disappearing into a world of fantasies filled with heroism, romance and action. When his job along with that of his co-worker are threatened, he takes action in the real world embarking on a global journey that turns into an adventure more extraordinary than anything he could have ever imagined.', 'the_secret_life_of_walter_mitty.jpg', 20, 20, '3,5,8', 1, 22),
(8, 'Intouchables', '1-04-2012', 2012, '2014-04-25 20:09:18', 'After he becomes a quadriplegic from a paragliding accident, an aristocrat hires a young man from the projects to be his caretaker.', 'intouchables.jpg', 20, 20, '4,5,8', 1, 15),
(9, 'Robot & Frank', '17-08-2012', 2012, '2014-04-25 20:25:17', 'Set in the near future, an ex-jewel thief receives a gift from his son: a robot butler programmed to look after him. But soon the two companions try their luck as a heist team.', 'robot_&_frank.jpg', 20, 20, '5,8,16', 1, 19),
(10, 'The Raid', '20-01-2012', 2012, '2014-04-25 20:40:56', 'A S.W.A.T. team becomes trapped in a tenement run by a ruthless mobster and his army of killers and thugs.', 'the_raid.jpg', 20, 20, '1,6,17', 1, 137);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `filme_detestate`
--

CREATE TABLE IF NOT EXISTS `filme_detestate` (
  `filme_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`filme_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Salvarea datelor din tabel `filme_detestate`
--

INSERT INTO `filme_detestate` (`filme_id`, `user_id`) VALUES
(8, 59),
(11, 59);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `filme_de_vazut`
--

CREATE TABLE IF NOT EXISTS `filme_de_vazut` (
  `filme_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`filme_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `filme_favorite`
--

CREATE TABLE IF NOT EXISTS `filme_favorite` (
  `filme_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`filme_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Salvarea datelor din tabel `filme_favorite`
--

INSERT INTO `filme_favorite` (`filme_id`, `user_id`) VALUES
(1, 59),
(3, 59),
(5, 59),
(6, 59),
(9, 59),
(10, 59);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `gen`
--

CREATE TABLE IF NOT EXISTS `gen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Salvarea datelor din tabel `gen`
--

INSERT INTO `gen` (`id`, `name`) VALUES
(1, 'Action'),
(2, 'Animation'),
(3, 'Adventures'),
(4, 'Biographical'),
(5, 'Comedy'),
(6, 'Crime'),
(7, 'Documentary'),
(8, 'Drama'),
(9, 'Horor'),
(10, 'Historical'),
(11, 'Mystery'),
(12, 'Musical'),
(13, 'War'),
(14, 'Romantic'),
(15, 'Sport'),
(16, 'Science Fiction'),
(17, 'Thriller'),
(18, 'Western');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `add_date` datetime NOT NULL,
  `telephone` int(11) NOT NULL,
  `address` varchar(70) NOT NULL,
  `billing_details` varchar(150) NOT NULL,
  `payment_method` varchar(60) NOT NULL,
  `shipping_method` varchar(60) NOT NULL,
  `status` varchar(50) NOT NULL,
  `obs` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Salvarea datelor din tabel `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `full_name`, `add_date`, `telephone`, `address`, `billing_details`, `payment_method`, `shipping_method`, `status`, `obs`) VALUES
(8, 59, 'Valimareanu Constantin', '0000-00-00 00:00:00', 720092780, 'Address: Str Lemnarilor nr 88-90\r\nCity: Bucharest', 'Full name: Valimareanu Constantin\r\nPerson type: Natural person\r\nAddress: Str Lemnarilor nr 88-90\r\nCi', 'ramburs', 'post', 'pending', ''),
(9, 59, 'Valimareanu Constantin', '0000-00-00 00:00:00', 720092780, 'Address: Str Lemnarilor nr 88-90\r\nCity: Bucharest', 'Full name: Valimareanu Constantin\r\nPerson type: Natural person\r\nAddress: Str Lemnarilor nr 88-90\r\nCi', 'ramburs', 'post', 'pending', '');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `order_product`
--

CREATE TABLE IF NOT EXISTS `order_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `filme_id` int(11) NOT NULL,
  `film_name` varchar(32) NOT NULL,
  `data` datetime NOT NULL,
  `price` decimal(6,0) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Salvarea datelor din tabel `order_product`
--

INSERT INTO `order_product` (`id`, `order_id`, `filme_id`, `film_name`, `data`, `price`, `qty`) VALUES
(4, 8, 4, '10.000 B.C.', '0000-00-00 00:00:00', '20', 1),
(5, 9, 4, '10.000 B.C.', '0000-00-00 00:00:00', '20', 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `private_message`
--

CREATE TABLE IF NOT EXISTS `private_message` (
  `id` int(16) NOT NULL,
  `sender_id` int(16) NOT NULL,
  `sender_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `reciever_id` int(16) NOT NULL,
  `message` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `viewed` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Salvarea datelor din tabel `private_message`
--

INSERT INTO `private_message` (`id`, `sender_id`, `sender_name`, `reciever_id`, `message`, `viewed`) VALUES
(0, 0, 'Joe', 66, 'Hi, how are you?', 1);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `ratings`
--

CREATE TABLE IF NOT EXISTS `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total_votes` int(5) NOT NULL DEFAULT '0',
  `total_value` int(5) NOT NULL DEFAULT '0',
  `used_ips` longtext NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Salvarea datelor din tabel `ratings`
--

INSERT INTO `ratings` (`id`, `total_votes`, `total_value`, `used_ips`, `add_date`) VALUES
(5, 0, 0, '', '2014-05-09 21:00:00'),
(10, 1, 4, 'a:1:{i:0;s:3:"::1";}', '2014-05-07 21:00:00'),
(11, 1, 5, 'a:1:{i:0;s:3:"::1";}', '2014-05-07 21:00:00');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `regizor`
--

CREATE TABLE IF NOT EXISTS `regizor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `birth_place` varchar(100) NOT NULL,
  `birth_date` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `biography` text NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `views` int(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Salvarea datelor din tabel `regizor`
--

INSERT INTO `regizor` (`id`, `first_name`, `last_name`, `birth_place`, `birth_date`, `country`, `biography`, `picture`, `views`) VALUES
(1, 'Marc', 'Webb', 'USA', '1991-05-16', 'USA', 'Marc Webb was born on August 31, 1974. He is a director and producer, known for The Amazing Spider-Man (2012), (500) Days of Summer (2009) and Uimitorul Om-Paianjen 2 (2014).', 'marc_webb.jpg', 0),
(2, 'James', 'Cameron', 'Kapuskasing, Ontario', 'August 16, 1954', 'Canada', 'James Francis Cameron was born on August 16, 1954 in Kapuskasing, Ontario, Canada. He moved to the United States in 1971. The son of an engineer, he majored in physics at California State University but, after graduating, drove a truck to support his screenwriting ambition. He landed his first professional film job as art director, miniature-set builder, and process-projection supervisor on Roger Corman''s Battle Beyond the Stars (1980) and debuted as a director with Piranha Part Two: The Spawning (1981) the following year. In 1984, he wrote and directed Terminatorul (1984), a futuristic action-thriller starring Arnold Schwarzenegger, Michael Biehn and Linda Hamilton. It was a huge success. After this came a string of successful science-fiction action films such as Aliens - Misiune de pedeapsa (1986), The Abyss (1989) and Terminator 2: Ziua judecatii (1991). In 1990, Cameron formed his own production company, Lightstorm Entertainment. In 1997, he wrote and directed Titanic (1997), a romance epic about two young lovers from social classes who meet on board the famous ship. The movie went on to break all box office records and earned eleven Academy Awards. It became the highest grossing movie of all time. The rest is history. James Cameron is now one of the most sought-after directors in Hollywood. He was formerly married to producer Gale Anne Hurd, who produced several of his films. In 2000, he married actress Suzy Amis, who appeared in Titanic, and they have three children.', 'james_cameron.jpg', 0),
(3, 'Wally', 'Pfister', 'Chicago, Illinois', '8 July 1961', 'USA', 'Wally Pfister was born on July 8, 1961 in Chicago, Illinois, USA as Walter Pfister. He is known for his work on Cavalerul negru (2008), Începutul (2010) and The Dark Knight Rises (2012). He has been married to Anna Julien since 1992.', 'wally_pfister.jpg', 0),
(4, 'Nicholas', 'Stoller', 'England', '19 March 1976', 'USA', 'Nicholas Stoller is an English-American screenwriter and director. He is known best for writing and directing the 2008 comedy Forgetting Sarah Marshall, and its 2010 spin-off/sequel, Get Him to the Greek. He also directed The Muppets and the Seth Rogen comedy, Neighbors. He is a frequent creative partner of Jason Segal.', 'nicolas_stoller.jpg', 0),
(5, 'Ben', 'Stiller', 'New York City, New York', '30 November 1965', 'USA', 'Ben Stiller was born on November 30, 1965, in New York, New York to legendary comedians Jerry Stiller and Anne Meara. It''s not surprising that Ben Stiller has followed in his family''s footsteps. Ben''s parents made no real effort to keep their son away from the Hollywood lifestyle and he grew up among the stars, wondering just why his parents were so popular. At a young age, he and his sister Amy Stiller would perform plays at home, wearing Amy''s tights to perform Shakespeare. Ben also picked up an interest in being on the other side of the camera and, at age 10, began shooting films on his Super 8 camera. The plots were always simple: someone would pick on the shy, awkward Stiller...and then he would always get his revenge. This desire for revenge on the popular, good-looking people may have motivated his teen-angst opus Reality Bites (1994) later in his career. He both directed and performed in the film, which costarred Winona Ryder and Ethan Hawke.\r\n\r\nBefore he even got his start in Hollywood, Ben put in several consistently solid years in the theater. After dropping out of UCLA, he performed in the Tony Award winner, "The House of Blue Leaves". While working on the play, Stiller shot a short spoof of Culoarea banilor (1986) starring him (in the Tom Cruise role) and his American Playhouse: The House of Blue Leaves (1987) costar John Mahoney (in the Paul Newman role). The short film was so funny that Lorne Michaels purchased it and aired it on Saturday Night Live (1975). This led to Ben spending a year on the show in 1989.\r\n\r\nBen made his big screen debut in Steven Spielberg''s Empire of the Sun (1987) in 1987. Demonstrating early on the multifaceted tone his career would take, he soon stepped behind the camera to direct Back to Brooklyn for MTV. The network was impressed and gave Stiller his own show, The Ben Stiller Show (1992). He recruited fellow offbeat comedians Janeane Garofalo and Andy Dick and created a bitingly satirical show. MTV ended up passing on it, but it was picked up by Fox. Unfortunately, the show was a ratings miss. Stiller was soon out of work, although he did have the satisfaction of picking up an Emmy for the show after its cancellation.\r\n\r\nFor a while, Ben had to settle for guest appearance work. While he was doing this, he saved up his cash and in the end was able to scrape enough together to make Reality Bites (1994), now a cult classic which is looked upon favorably by the generation it depicted. Ben continued to work steadily for a time, particularly in independent productions where he was more at ease. However, he never quite managed to catch a big break. His first big budget directing job was Jim Carrey''s The Cable Guy (1996). Although many critics were impressed, Jim Carrey''s fans were not.\r\n\r\nIn 1998, There''s Something About Mary (1998) had propelled Ben into the mainstream spotlight. With his wince-inducing turn in the Farrelly brothers'' gross-out film, Ben really "struck a nerve" with mainstream America. In recent years, Ben has starred in such hit movies as Preotul, rabinul si fata (2000) and Meet the Parents (2000). Ben excels at cerebral comedy, but he knows how to get down and lowbrow when he needs to, making him one of America''s currently most popular performers.', 'ben_stiller.jpg', 0),
(6, 'Olivier', 'Nakache', 'Suresnes, Hauts-de-Seine', '14 April 1973', 'France', 'Olivier Nakache was born on April 14, 1973 in Suresnes, Hauts-de-Seine, France. He is a director and writer, known for Invincibilii (2011), Nos jours heureux (2006) and Je préfère qu''on reste amis (2005).', 'olivier_nakache.jpg', 0),
(7, 'Eric', 'Toledano', 'Paris', '3 July 1971', 'France', 'Eric Toledano was born on July 3, 1971 in Paris, France. He is a director and writer, known for Invincibilii (2011), Nos jours heureux (2006) and Je préfère qu''on reste amis (2005).', 'eric_toledano.jpg', 0),
(8, 'Jake', 'Schreier', 'Berkeley, California', '1981', 'USA', 'Jake Schreier is a director and producer, known for Robot & Frank (2012), Christopher Ford Sees a Film (2005) and Untitled Jake Schreier/Chris Ford Project.', 'jake_schreier.jpg', 0),
(9, 'Gareth', 'Evans', 'Gareth Huw Evans', '1980', 'England, UK', 'Welsh born writer/director, in 2003 directed a short film "Samurai Monogatari" telling the tale of a Samurai waiting to be executed. The short was in Japanese language and starred students from Tokyo who were studying at Cardiff University at the time.\r\n\r\nIn 2003 he also graduated with an MA in Scriptwriting for Film and Television at the University of Glamorgan but it was not until 2006 that he would see his first major production with the self-penned feature "Footsteps". In 2006 the film premiered at the Swansea Bay Film Festival where it was awarded the prize for "Best Film", it has since gone on to recieve critical acclaim and is due to be released in the US through extreme cinema label, Unearthed Films in summer 2007.\r\n\r\nCurrently he is directing a documentary for Christine Hakim Films in Indonesia entitled "The Mystic Arts of Indonesia: Pencak Silat". The documentary is one of a five episode series covering the cultural heritage of Indonesia and is expected to broadcast once the series is complete in 2008.\r\n\r\nFollowing this he is expected to begin work on a second feature in summer 2007.', 'gareth_evans.jpg', 0),
(10, 'Bart', 'Layton', '-', '-', 'USA', 'Bart Layton is a producer and writer, known for The Imposter (2012), Banged Up Abroad (2006) and The Trouble with Black Men (2004).', 'bart_layton.jpg', 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `regizor_film`
--

CREATE TABLE IF NOT EXISTS `regizor_film` (
  `regizor_id` int(11) NOT NULL,
  `filme_id` int(11) NOT NULL,
  PRIMARY KEY (`regizor_id`,`filme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Salvarea datelor din tabel `regizor_film`
--

INSERT INTO `regizor_film` (`regizor_id`, `filme_id`) VALUES
(2, 1),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 8),
(8, 9),
(9, 10);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `trailer`
--

CREATE TABLE IF NOT EXISTS `trailer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filme_id` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `trailer` varchar(250) NOT NULL,
  `views` int(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Salvarea datelor din tabel `trailer`
--

INSERT INTO `trailer` (`id`, `filme_id`, `data`, `trailer`, `views`) VALUES
(1, 1, '2014-04-02 00:00:00', '<iframe width="560" height="315" src="//www.youtube.com/embed/cRdxXPV9GNQ" frameborder="0" allowfullscreen></iframe>', 0),
(2, 3, '2014-04-03 18:01:39', '<iframe width="560" height="315" src="//www.youtube.com/embed/7SlILk2WMTI" frameborder="0" allowfullscreen></iframe>', 0),
(3, 2, '2014-04-04 11:08:37', '<iframe width="560" height="315" src="//www.youtube.com/embed/1ECPknDXcVE" frameborder="0" allowfullscreen></iframe>', 0),
(6, 4, '2014-04-10 11:58:55', '<iframe width="420" height="315" src="//www.youtube.com/embed/xuBkPhg3KjM" frameborder="0" allowfullscreen></iframe>', 0),
(7, 0, '2014-04-11 11:09:04', '<iframe width="560" height="315" src="//www.youtube.com/embed/6hB3S9bIaco" frameborder="0" allowfullscreen></iframe>', 0),
(8, 5, '2014-04-23 14:38:01', '<iframe width="560" height="315" src="//www.youtube.com/embed/VCTen3-B8GU" frameborder="0" allowfullscreen></iframe>', 0),
(9, 6, '2014-04-25 19:43:10', '<iframe width="560" height="315" src="//www.youtube.com/embed/pzZgJZMXNEc" frameborder="0" allowfullscreen></iframe>', 0),
(10, 7, '2014-04-25 19:59:53', '<iframe width="560" height="315" src="//www.youtube.com/embed/c1Xk-yTuFEU" frameborder="0" allowfullscreen></iframe>', 0),
(11, 8, '2014-04-25 20:10:23', '<iframe width="560" height="315" src="//www.youtube.com/embed/34WIbmXkewU" frameborder="0" allowfullscreen></iframe>', 0),
(12, 9, '2014-04-25 20:25:42', '<iframe width="560" height="315" src="//www.youtube.com/embed/nJRnMnz7fNo" frameborder="0" allowfullscreen></iframe>', 0),
(13, 10, '2014-04-25 20:41:36', '<iframe width="560" height="315" src="//www.youtube.com/embed/PkULMOFpuCo" frameborder="0" allowfullscreen></iframe>', 0),
(14, 10, '2014-05-14 21:30:01', '<iframe width="560" height="315" src="//www.youtube.com/embed/HITcLGS38zk" frameborder="0" allowfullscreen></iframe>', 0);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `bio` text,
  `user_a` int(2) NOT NULL DEFAULT '0',
  `status` varchar(16) NOT NULL DEFAULT 'not_activated',
  `code` varchar(8) NOT NULL,
  `created` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=67 ;

--
-- Salvarea datelor din tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `picture`, `bio`, `user_a`, `status`, `code`, `created`) VALUES
(0, '', '', '', '', '', 'all.jpg', NULL, 0, 'not_activated', '', ''),
(59, 'Valimareanu', 'a580233276a6141e4d1cde47e06bcac6', 'Valimareanu', 'Constantin', 'daemon_vali@yahoo.com', 'valimareanu690117leth.jpg', 'I am a web programmer.', 1, 'activated', '', '28.04.2014'),
(66, 'mandarinul', 'b26571982eff8cb34084c806f7862bd9', 'George', 'Andrei', 'valimareanu16@gmail.com', 'all.jpg', 'I am a user.', 0, 'activated', '', '0');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `user_details`
--

CREATE TABLE IF NOT EXISTS `user_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `company` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `commercial_register_number` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `tax_identification_number` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `telephone` int(15) NOT NULL,
  `address` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Salvarea datelor din tabel `user_details`
--

INSERT INTO `user_details` (`id`, `person_type`, `full_name`, `company`, `commercial_register_number`, `tax_identification_number`, `telephone`, `address`, `city`, `country`, `user_id`) VALUES
(1, 'Natural person', 'Valimareanu Constantin', '', '', '', 720092780, 'Str Lemnarilor nr 88-90', 'Bucharest', 'Romania', 59);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
