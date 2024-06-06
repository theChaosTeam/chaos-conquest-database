create table clash
(
    ID        int auto_increment
        primary key,
    StartDate time        not null,
    EndDate   time        not null,
    Prize     varchar(50) not null
);

create table competitiverank
(
    ID   int auto_increment
        primary key,
    Name varchar(50) not null
);

create table damagetype
(
    ID   int auto_increment
        primary key,
    Type enum ('Magic', 'Physic', 'Mixed') not null
);

create table champion
(
    ID              int auto_increment
        primary key,
    Name            varchar(50)                                     not null,
    Role            enum ('Top', 'Jungle', 'Mid', 'ADC', 'Support') not null,
    DamageType      int                                             not null,
    HealthPoints    int                                             not null,
    ManaPoints      int                                             not null,
    Damage          int                                             not null,
    MovementSpeed   decimal                                         not null,
    Armor           int                                             not null,
    MagicResistance int                                             not null,
    AttackSpeed     decimal                                         not null,
    constraint Champion_damagetype_ID_fk
        foreign key (DamageType) references damagetype (ID)
);

create table championability
(
    ID          int auto_increment
        primary key,
    ChampionID  int                        not null,
    Name        varchar(50)                not null,
    Description varchar(500)               not null,
    Damage      int                        not null,
    DamageType  int                        not null,
    Cooldown    decimal                    not null,
    Type        enum ('Passive', 'Active') not null,
    constraint championability_champion_ID_fk
        foreign key (ChampionID) references champion (ID),
    constraint championability_damagetype_ID_fk
        foreign key (DamageType) references damagetype (ID)
);

create table championskin
(
    ID         int auto_increment
        primary key,
    ChampionID int         not null,
    Name       varchar(50) not null,
    Price      int         not null,
    constraint Championskin_champion_ID_fk
        foreign key (ChampionID) references champion (ID)
);

create table item
(
    ID    int auto_increment
        primary key,
    Name  varchar(50) not null,
    Price int         not null
);

create table itemstat
(
    ID      int auto_increment
        primary key,
    ItemId  int          not null,
    Effects varchar(300) not null,
    constraint ItemStat_item_ID_fk
        foreign key (ItemId) references item (ID)
);

create table matchhistory
(
    ID            int auto_increment
        primary key,
    ChampionsID   int         not null,
    WinnerTeam    varchar(50) not null,
    MatchDuration time        not null,
    MatchDate     timestamp   not null,
    constraint MatchHistory_champion_ID_fk
        foreign key (ChampionsID) references champion (ID)
);

create table ownedskins
(
    SkinID     int                    not null,
    ChampionID int                    not null,
    Owned      enum ('True', 'False') not null,
    primary key (SkinID, ChampionID),
    constraint Ownedskins_champion_ID_fk
        foreign key (ChampionID) references champion (ID),
    constraint Ownedskins_championskin_ID_fk
        foreign key (SkinID) references championskin (ID)
);

create table patchhistory
(
    ID          int auto_increment
        primary key,
    Number      decimal      not null,
    Description varchar(500) not null
);

create table player
(
    ID                    int auto_increment
        primary key,
    NickName              varchar(100) not null,
    Level                 int          not null,
    `Rank`                int          not null,
    ` MostPlayedChampion` int          not null,
    constraint Player_champion_ID_fk
        foreign key (` MostPlayedChampion`) references champion (ID),
    constraint Player_competitiverank_ID_fk
        foreign key (`Rank`) references competitiverank (ID)
);

create table clashparticipant
(
    ClashID  int not null,
    PlayerID int not null,
    primary key (ClashID, PlayerID),
    constraint ClashParticipant_clash_ID_fk
        foreign key (ClashID) references clash (ID),
    constraint ClashParticipant_player_ID_fk
        foreign key (PlayerID) references player (ID)
);

create table itemloadout
(
    MatchID  int not null,
    ItemID   int not null,
    PlayerID int not null,
    primary key (MatchID, ItemID, PlayerID),
    constraint Itemloadout_item_ID_fk
        foreign key (ItemID) references item (ID),
    constraint Itemloadout_matchhistory_ID_fk
        foreign key (MatchID) references matchhistory (ID),
    constraint Itemloadout_player_ID_fk
        foreign key (PlayerID) references player (ID)
);

create table mastery
(
    ID         int auto_increment
        primary key,
    ChampionID int not null,
    PlayerID   int not null,
    Level      int not null,
    Points     int not null,
    constraint Mastery_champion_ID_fk
        foreign key (ChampionID) references champion (ID),
    constraint Mastery_player_ID_fk
        foreign key (PlayerID) references player (ID)
);

create table matchstats
(
    ID            int auto_increment
        primary key,
    MatchId       int                  not null,
    Kills         int                  not null,
    Deaths        int                  not null,
    GoldEarned    int                  not null,
    Assists       int                  not null,
    DealtDamage   int                  not null,
    RecivedDamage int                  not null,
    Team          enum ('Blue', 'Red') not null,
    PlayerID      int                  not null,
    constraint MatchStats_matchhistory_ID_fk
        foreign key (MatchId) references matchhistory (ID),
    constraint matchstats_player_ID_fk
        foreign key (PlayerID) references player (ID)
);

create table ownedchampions
(
    ChampionsId int                    not null,
    PlayerId    int                    not null,
    Owned       enum ('True', 'False') not null,
    primary key (ChampionsId, PlayerId),
    constraint OwnedChampions_champion_ID_fk
        foreign key (ChampionsId) references champion (ID),
    constraint OwnedChampions_player_ID_fk
        foreign key (PlayerId) references player (ID)
);

create table runepath
(
    ID          int auto_increment
        primary key,
    Path        varchar(50)  not null,
    Description varchar(500) not null
);

create table rune
(
    ID          int auto_increment
        primary key,
    Path        int          not null,
    Name        varchar(50)  not null,
    Description varchar(500) not null,
    constraint Rune_runepath_ID_fk
        foreign key (ID) references runepath (ID)
);

create table runeloadout
(
    MatchId  int not null,
    RuneId   int not null,
    PlayerId int not null,
    primary key (MatchId, RuneId, PlayerId),
    constraint RuneLoadout_matchhistory_ID_fk
        foreign key (MatchId) references matchhistory (ID),
    constraint RuneLoadout_player_ID_fk
        foreign key (PlayerId) references player (ID),
    constraint RuneLoadout_rune_ID_fk
        foreign key (RuneId) references rune (ID)
);

INSERT INTO clash (StartDate, EndDate, Prize) VALUES 
('2024-05-01 09:00:00', '2024-05-02 09:00:00', 'First Place: $1000'),
('2024-06-15 10:00:00', '2024-06-16 10:00:00', 'First Place: $1500'),
('2024-07-20 12:00:00', '2024-07-21 12:00:00', 'First Place: $2000');

INSERT INTO competitiverank (Name) VALUES 
('Bronze'),
('Silver'),
('Gold');

INSERT INTO damagetype (Type) VALUES 
('Magic'),
('Physic'),
('Mixed');

INSERT INTO champion (Name, Role, DamageType, HealthPoints, ManaPoints, Damage, MovementSpeed, Armor, MagicResistance, AttackSpeed) VALUES 
('Garen', 'Top', 0, 600, 0, 60, 345, 35, 25, 0.65),
('Ahri', 'Mid', 1, 500, 300, 55, 330, 20, 30, 0.7),
('KaiSa', 'ADC', 2, 550, 325, 64, 335, 28, 30, 0.669);

INSERT INTO championability (ChampionID, Name, Description, Damage, DamageType, Cooldown, Type) VALUES 
(1, 'Decisive Strike', 'Garen breaks free from all slows affecting him and gains 30% movement speed for a few seconds. His next attack strikes a vital area of his foe, dealing bonus damage and silencing them.', 100, 1, 8, 'Active'),
(2, 'Orb of Deception', 'Ahri sends out an orb in a line in front of her and then pulls it back, dealing magic damage on the way out and true damage on the way back.', 90, 0, 6, 'Active'),
(3, 'Icathian Rain', 'KaiSa releases a swarm of missiles evenly distributed among nearby enemies, with nearby isolated targets being targeted first.', 25, 1, 10, 'Active');

INSERT INTO championskin (ChampionID, Name, Price) VALUES 
(1, 'God-King Garen', 1850),
(2, 'K/DA Ahri', 1350),
(3, 'Star Guardian KaiSa', 1850);

INSERT INTO item (Name, Price) VALUES 
('Infinity Edge', 3400),
('Luden''s Tempest', 3200),
('Sunfire Aegis', 3200);

INSERT INTO itemstat (ItemId, Effects) VALUES 
(1, '70 Attack Damage, 20% Critical Strike Chance'),
(2, '80 Ability Power, 10% Magic Penetration'),
(3, '450 Health, 35 Armor, 35 Magic Resist');

INSERT INTO matchhistory (ChampionsID, WinnerTeam, MatchDuration, MatchDate) VALUES 
(1, 'Blue', '00:30:00', '2024-05-01 10:00:00'),
(2, 'Red', '00:40:00', '2024-05-02 14:00:00'),
(3, 'Blue', '00:35:00', '2024-05-03 18:00:00');

INSERT INTO ownedskins (SkinID, ChampionID, Owned) VALUES 
(1, 1, 'True'),
(2, 2, 'True'),
(3, 3, 'True');

INSERT INTO patchhistory (Number, Description) VALUES 
(11.12, 'Balance changes to multiple champions and items.'),
(11.13, 'Introduction of new champion skins and cosmetic updates.'),
(11.14, 'Bug fixes and minor adjustments to item stats.');

INSERT INTO player (NickName, Level, Rank, ` MostPlayedChampion`) VALUES 
('GamerGuy123', 30, 3, 1),
('ProPlayer99', 40, 5, 2),
('MasterChallenger', 50, 1, 3);

INSERT INTO clashparticipant (ClashID, PlayerID) VALUES 
(1, 1),
(2, 2),
(3, 3);

INSERT INTO itemloadout (MatchID, ItemID, PlayerID) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

INSERT INTO mastery (ChampionID, PlayerID, Level, Points) VALUES 
(1, 1, 5, 350),
(2, 2, 7, 500),
(3, 3, 4, 250);

INSERT INTO matchstats (MatchId, Kills, Deaths, GoldEarned, Assists, DealtDamage, RecivedDamage, Team, PlayerID) VALUES 
(1, 10, 2, 15000, 15, 20000, 18000, 'Blue', 1),
(2, 7, 3, 18000, 12, 25000, 22000, 'Red', 2),
(3, 5, 1, 16000, 10, 22000, 20000, 'Blue', 3);

INSERT INTO ownedchampions (ChampionsId, PlayerId, Owned) VALUES 
(1, 1, 'True'),
(2, 2, 'True'),
(3, 3, 'True');

INSERT INTO runepath (Path, Description) VALUES 
('Precision', 'Focuses on enhancing basic attacks and critical hits.'),
('Sorcery', 'Emphasizes spells and magical damage.'),
('Resolve', 'Strengthens defenses and sustainability.');

INSERT INTO rune (Path, Name, Description) VALUES 
(1, 'Conqueror', 'Basic attacks or spells that deal damage to an enemy champion grant 2 stacks of Conqueror for 6s, gaining 1.7-4.2 Bonus AD per stack. Stacks up to 12 times.'),
(2, 'Summon Aery', 'Your attacks and abilities send Aery to a target, damaging enemies or shielding allies.'),
(3, 'Grasp of the Undying', 'Every 4s in combat, your next basic attack on a champion will: Deal bonus magic damage, Heal you for 2% of your max health, Permanently increase your health by 5.');

INSERT INTO runeloadout (MatchId, RuneId, PlayerId) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);
