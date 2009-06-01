# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 28;
use DateTime;
use Data::Dumper;

BEGIN { use_ok( 'DateTime::AATW' ); }

### Create DateTime and check that new() works
my $dt = DateTime->new(month=>3,day=>10,hour=>1,minute=>0,year=>2009,time_zone=>'UTC');
my $aatw = DateTime::AATW->new($dt);
ok(ref $aatw eq 'DateTime::AATW');


### Check that zone_names_for_hour returns correct arrayref
my $zone_names_for_hour_2_ref = $aatw->zone_names_for_hour(2);
ok(ref $zone_names_for_hour_2_ref eq 'ARRAY');
ok(scalar @{$zone_names_for_hour_2_ref} == 36);

my $zone_names_for_hour_2_ref_are_names = 1;
foreach my $name (@$zone_names_for_hour_2_ref) {
    $zone_names_for_hour_2_ref_are_names = 0 if ref $name;
}
ok($zone_names_for_hour_2_ref_are_names);
###


### Check that zone_names_for_hour returns correct array
my @zone_names_for_hour_2_ary = $aatw->zone_names_for_hour(2);
ok(scalar @zone_names_for_hour_2_ary == 36);

my $zone_names_for_hour_2_ary_are_names = 1;
foreach my $name (@zone_names_for_hour_2_ary) {
    $zone_names_for_hour_2_ary_are_names = 0 if ref $name;
}
ok($zone_names_for_hour_2_ary_are_names);
###


### Check that zone_names_for_hour returns undef for incorrect hour
my $zone_names_for_hour_24_ref = $aatw->zone_names_for_hour(24);
ok(!(defined $zone_names_for_hour_24_ref));

my @zone_names_for_hour_24_ary = $aatw->zone_names_for_hour(24);
ok(@zone_names_for_hour_24_ary);
ok(!(defined $zone_names_for_hour_24_ary[0]));
###


### Check that zone_names_for_hours returns correct arrayref
my $zone_names_for_hours_2and5_ref = $aatw->zone_names_for_hours(2,5);
ok(ref $zone_names_for_hours_2and5_ref eq 'ARRAY');
ok(scalar @{$zone_names_for_hours_2and5_ref} == 46);
###

### Check that zone_names_for_hours returns correct array
my @zone_names_for_hours_2and5_ary = $aatw->zone_names_for_hours(2,5);
ok(scalar @zone_names_for_hours_2and5_ary == 46);
###


### Check that zones_for_hours returns correct arrayref
my $zones_for_hour_2_ref = $aatw->zones_for_hour(2);
ok(ref $zones_for_hour_2_ref eq 'ARRAY');
ok(scalar @{$zone_names_for_hour_2_ref} == 36);
###

my @zones_for_hour_2_ary = $aatw->zones_for_hour(2);
ok(scalar @zones_for_hour_2_ary == 36);


my $zones_for_hour_24_ref = $aatw->zones_for_hour(24);
ok(!(defined $zones_for_hour_24_ref));

my @zones_for_hour_24_ary = $aatw->zones_for_hour(24);
ok(@zones_for_hour_24_ary);
ok(!(defined $zones_for_hour_24_ary[0]));


my $zones_for_hours_2and5_ref = $aatw->zones_for_hours(2,5);
ok(ref $zones_for_hours_2and5_ref eq 'ARRAY');
ok(scalar @{$zones_for_hours_2and5_ref} == 46);

my @zones_for_hours_2and5_ary = $aatw->zones_for_hours(2,5);
ok(scalar @zones_for_hours_2and5_ary == 46);


ok(ref $aatw->dt_for_zone('America/New_York') eq 'DateTime');
ok(DateTime->compare($aatw->dt_for_zone('America/New_York'),
   DateTime->new(year=>2009,
                 month=>3,
                 day=>9,
                 hour=>21,
                 minute=>0,
                 time_zone=>'America/New_York')) == 0);


my $hour2_zones_map = $aatw->hour_zones_map(2);
my @hour2_zones_map_keys = keys %$hour2_zones_map;
ok(@hour2_zones_map_keys == 1);
ok($hour2_zones_map_keys[0] == 2); 
ok(ref ($hour2_zones_map->{$hour2_zones_map_keys[0]}) eq 'ARRAY');

my $hour2416_zones_map = $aatw->hour_zones_map(2,4,16);
my @hour2416_zones_map_keys = keys %$hour2416_zones_map;
ok(@hour2416_zones_map_keys == 3);



