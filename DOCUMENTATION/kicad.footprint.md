# KiCad Footprint Creation Checklist

## Initial Setup
- [ ] Set grid size appropriately for component dimensions
- [ ] Verify units (mm/inches) match datasheet specifications
- [ ] Create new library if needed with meaningful name
- [ ] Name footprint according to standard naming conventions
- [ ] Add reference designator (REF**) text

## Pad Creation
- [ ] Verify pad dimensions match datasheet
- [ ] Check pad numbering sequence
- [ ] Set correct pad types (SMD/THT)
- [ ] Verify pad shapes (rectangular, oval, custom)
- [ ] Add thermal relief settings for THT pads if needed
- [ ] Check pad clearances meet manufacturing requirements

## Mechanical
- [ ] Add courtyard with appropriate clearance
- [ ] Create fabrication layer outline
- [ ] Add component outline on silkscreen
- [ ] Verify pin 1 indicator is clear and visible
- [ ] Check component orientation indicator
- [ ] Add 3D model reference if available

## Measurements & Verification
- [ ] Double-check all critical dimensions against datasheet
- [ ] Verify pad-to-pad spacing
- [ ] Check symmetry where applicable
- [ ] Verify origin point placement
- [ ] Confirm footprint center aligns with component center
- [ ] Check all dimensions are manufacturable (not too small)

## Documentation
- [ ] Add datasheet link in footprint properties
- [ ] Document any special requirements or notes
- [ ] Add footprint tags for easy searching
- [ ] Include manufacturer part number if specific
- [ ] Note package type (e.g., SOIC-8, QFN-32)

## Final Review
- [ ] Run DRC check
- [ ] Preview in 3D viewer
- [ ] Verify footprint against similar existing footprints
- [ ] Check footprint appears correctly in library browser
- [ ] Test footprint in a test board if possible
- [ ] Verify all layers are correctly assigned

## Common Mistakes to Avoid
- [ ] Don't mix up pad numbers
- [ ] Don't forget the courtyard
- [ ] Don't make silkscreen overlap pads
- [ ] Don't make features too small for manufacturing
- [ ] Don't forget to add reference designator
- [ ] Don't place text on copper layers unless intended