#!/usr/bin/perl

@out = `sudo killall cgminer ; sudo ~/cgminer/cgminer`;
for (@out) {
	push(@{$res{$1}}, $2) if m/BITFURY slot: (\d+).*#(\d+) detected/;
	print "$1\n" if m/BITFURY: (.*chips detected)/;
}
$cards = keys %res;
print "$cards cards: \n";
for (sort keys %res) {
	@chips = @{$res{$_}};
	$total = @chips;
	print "$_ -> $total\n";
}