/* Hose Adapter
 * Adapt between vacuum cleaner end and flexible hose
 */

$fn=100;

hose_id=39;
vacuum_od=35;
length=30;
collar_od=(hose_id+7);
collar_height=3;


module vacuum(length) {
    cylinder(h=length, d1=vacuum_od, d2=vacuum_od-0.5);
}

module hose(length) {
    hull() {
        union() {
            cylinder(h=length-3, d=hose_id);
            cylinder(h=length, d=hose_id-2);
        }
    }
}

module collar() {
    cylinder(h=collar_height, d=collar_od);
}


module adapter(length) {
    difference() {
        union() {
            collar();
            hose(length);
        }
        vacuum(length);
    }
}

adapter(length);
