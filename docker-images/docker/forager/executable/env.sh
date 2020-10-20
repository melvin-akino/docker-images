#!/bin/bash
export KAFKA_HOST="kafka:9092"
export KAFKA_PORT="9092"
export KAFKA_EVENT_TOPIC=SCRAPING-PROVIDER-EVENTS
export KAFKA_LEAGUE_TOPIC=SCRAPING-PROVIDER-LEAGUES
export KAFKA_ODDS_TOPIC=SCRAPING-ODDS
export REDIS_HOST="redis"
export REDIS_PORT="6379"
export PROXY_PASSWORD=27g66cr17a7h
export PROXY_ZONE_URL=http://lum-customer-arvin_gavino-zone-np2
export KAFKA_BOOTSTRAP_SERVER="kafka://kafka:9092"
export REDIS_SERVER="redis://redis:6379"
export CONSUMER_AUTO_OFFSET_RESET=latest
export LPM_CERTIFICATE=/scraper/multiline_scrapy/lpm/ca.crt
export FILTERED_TEAMS="No. of Corners, No. of Bookings,Extra Time, To Qualify, (Corners), Winner, PK(Handicap), PK(Over/Under), games (e.g', 'Days (, Game, Corners, borders, To Win Final, To Finish 3rd, To Advance, (w), (n), Home Team, Away Team, To Win, TEST"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES