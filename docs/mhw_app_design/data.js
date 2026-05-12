// Loadout — mock equipment + builds data (original fantasy names, no real-game IPs)
window.LOADOUT_DATA = (() => {

  // ── Equipment catalog ──────────────────────────────────────────────────────
  const weapons = [
    { id: 'w1', kind: 'weapon', name: 'Stormwarden', type: 'Greatsword', rarity: 7, attack: 1248, affinity: 10, element: { type: 'thunder', value: 240 }, slots: [3, 2, 1], sharpness: 0.86, skills: [['Critical Eye', 2]] },
    { id: 'w2', kind: 'weapon', name: 'Frostbite Edge', type: 'Longsword', rarity: 6, attack: 1056, affinity: 25, element: { type: 'ice', value: 380 }, slots: [2, 1], sharpness: 0.78, skills: [['Razor Sharp', 1]] },
    { id: 'w3', kind: 'weapon', name: 'Embercast Bow', type: 'Bow', rarity: 7, attack: 924, affinity: 15, element: { type: 'fire', value: 420 }, slots: [3, 1, 1], sharpness: 0.72, skills: [['Quick Shot', 2]] },
    { id: 'w4', kind: 'weapon', name: 'Hollowsong Hammer', type: 'Hammer', rarity: 6, attack: 1392, affinity: -10, element: null, slots: [2, 2], sharpness: 0.81, skills: [['Slugger', 2]] },
    { id: 'w5', kind: 'weapon', name: 'Voidwhisper Lance', type: 'Lance', rarity: 8, attack: 1100, affinity: 30, element: { type: 'dragon', value: 320 }, slots: [3, 3, 2], sharpness: 0.92, skills: [['Guard Up', 1]] },
  ];

  const head = [
    { id: 'h1', kind: 'head', name: 'Ashveil Hood', rarity: 7, defense: 124, fire: -2, water: 1, thunder: 3, ice: -3, dragon: 0, slots: [3], skills: [['Critical Eye', 2], ['Weak Point', 1]] },
    { id: 'h2', kind: 'head', name: 'Tideborn Crown', rarity: 6, defense: 108, fire: -3, water: 4, thunder: -2, ice: 2, dragon: 0, slots: [2, 1], skills: [['Tide Surge', 2]] },
    { id: 'h3', kind: 'head', name: 'Ironvein Helm', rarity: 5, defense: 142, fire: 0, water: 0, thunder: 0, ice: 0, dragon: 1, slots: [1], skills: [['Defense Boost', 1]] },
  ];

  const chest = [
    { id: 'c1', kind: 'chest', name: 'Ashveil Mantle', rarity: 7, defense: 132, fire: -1, water: 0, thunder: 4, ice: -2, dragon: 0, slots: [2, 2], skills: [['Critical Eye', 1], ['Power', 2]] },
    { id: 'c2', kind: 'chest', name: 'Wyrmguard Mail', rarity: 6, defense: 156, fire: 1, water: 1, thunder: 1, ice: 1, dragon: 3, slots: [1, 1], skills: [['Health Boost', 2]] },
  ];

  const arms = [
    { id: 'a1', kind: 'arms', name: 'Thornward Vambraces', rarity: 7, defense: 116, fire: -1, water: 2, thunder: 2, ice: -2, dragon: 0, slots: [3, 1], skills: [['Weak Point', 2]] },
    { id: 'a2', kind: 'arms', name: 'Stoneform Gauntlets', rarity: 5, defense: 134, fire: 0, water: 0, thunder: 0, ice: 0, dragon: 2, slots: [1], skills: [['Guard', 2]] },
  ];

  const waist = [
    { id: 'b1', kind: 'waist', name: 'Bramblehide Coil', rarity: 7, defense: 122, fire: 0, water: 1, thunder: 3, ice: -1, dragon: 0, slots: [2, 2, 1], skills: [['Stamina Surge', 1], ['Power', 1]] },
    { id: 'b2', kind: 'waist', name: 'Cinderbelt', rarity: 6, defense: 118, fire: 4, water: -2, thunder: 0, ice: -3, dragon: 0, slots: [2], skills: [['Heat Resistance', 2]] },
  ];

  const legs = [
    { id: 'l1', kind: 'legs', name: 'Gildedsole Greaves', rarity: 7, defense: 128, fire: -2, water: 1, thunder: 4, ice: -3, dragon: 0, slots: [3], skills: [['Critical Eye', 1], ['Evade Window', 2]] },
    { id: 'l2', kind: 'legs', name: 'Hearthstride Boots', rarity: 6, defense: 124, fire: 2, water: 0, thunder: 0, ice: 1, dragon: 0, slots: [2, 1], skills: [['Constitution', 2]] },
  ];

  const charm = [
    { id: 'm1', kind: 'charm', name: 'Talisman of Resolve', rarity: 6, slots: [], skills: [['Critical Eye', 3]] },
    { id: 'm2', kind: 'charm', name: 'Talisman of Vigor', rarity: 5, slots: [], skills: [['Health Boost', 2]] },
  ];

  const all = [...weapons, ...head, ...chest, ...arms, ...waist, ...legs, ...charm];
  const byId = Object.fromEntries(all.map(e => [e.id, e]));

  // ── Jewels (decorations) ───────────────────────────────────────────────────
  // level = required slot size; grants skill at the given level
  const jewels = [
    { id: 'jw-crit',   name: 'Critical Jewel',  level: 2, skill: 'Critical Eye',  amount: 1 },
    { id: 'jw-tend',   name: 'Tenderizer Jewel', level: 2, skill: 'Weak Point',    amount: 1 },
    { id: 'jw-pwr',    name: 'Power Jewel',     level: 1, skill: 'Power',          amount: 1 },
    { id: 'jw-vit',    name: 'Vitality Jewel',  level: 1, skill: 'Health Boost',   amount: 1 },
    { id: 'jw-stam',   name: 'Stamina Jewel',   level: 1, skill: 'Stamina Surge',  amount: 1 },
    { id: 'jw-evade',  name: 'Evasion Jewel',   level: 2, skill: 'Evade Window',   amount: 1 },
    { id: 'jw-razor',  name: 'Razor Jewel',     level: 2, skill: 'Razor Sharp',    amount: 1 },
    { id: 'jw-quick',  name: 'Quickshot Jewel', level: 2, skill: 'Quick Shot',     amount: 1 },
    { id: 'jw-tide',   name: 'Tidal Jewel',     level: 2, skill: 'Tide Surge',     amount: 1 },
    { id: 'jw-slug',   name: 'Slugger Jewel',   level: 2, skill: 'Slugger',        amount: 1 },
    { id: 'jw-defens', name: 'Defense Jewel',   level: 1, skill: 'Defense Boost',  amount: 1 },
    { id: 'jw-guard',  name: 'Guard Jewel',     level: 2, skill: 'Guard',          amount: 1 },
    { id: 'jw-cons',   name: 'Constitution Jewel', level: 2, skill: 'Constitution', amount: 1 },
    { id: 'jw-heat',   name: 'Heat Jewel',      level: 1, skill: 'Heat Resistance', amount: 1 },
    { id: 'jw-crit3',  name: 'Critical+ Jewel', level: 3, skill: 'Critical Eye',  amount: 2 },
    { id: 'jw-pwr3',   name: 'Power+ Jewel',    level: 3, skill: 'Power',          amount: 2 },
  ];
  const jewelsById = Object.fromEntries(jewels.map(j => [j.id, j]));

  // ── Skills catalog (descriptions) ──────────────────────────────────────────
  const skills = {
    'Critical Eye':       { max: 7, color: 'orange',  desc: 'Increases affinity.', perLevel: { 1: '+5%', 2: '+10%', 3: '+15%', 4: '+20%', 5: '+25%' } },
    'Weak Point':         { max: 3, color: 'red',     desc: 'Increases affinity when attacking weak spots.', perLevel: { 1: '+15%', 2: '+30%', 3: '+50%' } },
    'Power':              { max: 7, color: 'red',     desc: 'Increases raw attack.', perLevel: { 1: '+3', 2: '+6', 3: '+9', 4: '+7 ×4%', 5: '+8 ×6%' } },
    'Razor Sharp':        { max: 3, color: 'gray',    desc: 'Sharpness depletes more slowly.' },
    'Quick Shot':         { max: 3, color: 'orange',  desc: 'Speeds up bow charging.' },
    'Slugger':            { max: 3, color: 'purple',  desc: 'Strengthens stun power.' },
    'Guard Up':           { max: 1, color: 'blue',    desc: 'Block normally unblockable attacks.' },
    'Guard':              { max: 5, color: 'blue',    desc: 'Reduces knockback while blocking.' },
    'Tide Surge':         { max: 3, color: 'cyan',    desc: 'Boosts water element power.' },
    'Heat Resistance':    { max: 3, color: 'orange',  desc: 'Mitigates heat environment damage.' },
    'Defense Boost':      { max: 7, color: 'gray',    desc: 'Increases base defense and resistances.' },
    'Health Boost':       { max: 3, color: 'green',   desc: 'Increases max health.', perLevel: { 1: '+15', 2: '+30', 3: '+50' } },
    'Stamina Surge':      { max: 3, color: 'green',   desc: 'Speeds up stamina recovery.' },
    'Constitution':       { max: 5, color: 'green',   desc: 'Reduces stamina depleted by evading and blocking.' },
    'Evade Window':       { max: 5, color: 'cyan',    desc: 'Extends invulnerability while evading.' },
  };

  // ── Default active build ───────────────────────────────────────────────────
  const activeBuild = {
    id: 'b1',
    name: 'Stormrunner',
    note: 'Crit-heavy thunder bow set',
    slots: { weapon: 'w1', head: 'h1', chest: 'c1', arms: 'a1', waist: 'b1', legs: 'l1', charm: 'm1' },
    decorations: { 'w1-0': 'jw-crit', 'a1-0': 'jw-tend' },
  };

  const savedBuilds = [
    activeBuild,
    {
      id: 'b2', name: 'Brickwall',  note: 'Max defense, guard build',
      slots: { weapon: 'w5', head: 'h3', chest: 'c2', arms: 'a2', waist: 'b2', legs: 'l2', charm: 'm2' },
      decorations: {},
    },
    {
      id: 'b3', name: 'Coldsnap',   note: 'Ice longsword, mid game',
      slots: { weapon: 'w2', head: 'h2', chest: 'c1', arms: 'a1', waist: 'b1', legs: 'l1', charm: 'm1' },
      decorations: {},
    },
    {
      id: 'b4', name: 'Firestorm',  note: 'Bow + fire focus',
      slots: { weapon: 'w3', head: 'h1', chest: 'c1', arms: 'a1', waist: 'b2', legs: 'l1', charm: 'm1' },
      decorations: {},
    },
  ];

  // ── Compute aggregate stats ────────────────────────────────────────────────
  function computeStats(build) {
    const pieces = ['weapon', 'head', 'chest', 'arms', 'waist', 'legs', 'charm']
      .map(k => byId[build.slots[k]]).filter(Boolean);
    const w = pieces.find(p => p.kind === 'weapon');
    const armorPieces = pieces.filter(p => p && p.kind !== 'weapon' && p.kind !== 'charm');

    const defense = armorPieces.reduce((s, p) => s + (p.defense || 0), 0);
    const res = ['fire','water','thunder','ice','dragon'].reduce((acc, k) => {
      acc[k] = armorPieces.reduce((s, p) => s + (p[k] || 0), 0);
      return acc;
    }, {});

    // Aggregate skills (from gear)
    const skillLevels = {};
    pieces.forEach(p => (p.skills || []).forEach(([n, lv]) => {
      skillLevels[n] = (skillLevels[n] || 0) + lv;
    }));
    // Aggregate skills (from equipped jewels)
    Object.entries(build.decorations || {}).forEach(([key, jewelId]) => {
      if (!jewelId) return;
      const j = jewelsById[jewelId];
      if (!j) return;
      skillLevels[j.skill] = (skillLevels[j.skill] || 0) + j.amount;
    });

    return {
      attack: w ? w.attack : 0,
      affinity: w ? w.affinity : 0,
      element: w ? w.element : null,
      sharpness: w ? w.sharpness : 0,
      defense, res, skills: skillLevels,
      slots: pieces.flatMap(p => p.slots || []),
    };
  }

  return { weapons, head, chest, arms, waist, legs, charm, all, byId, skills, jewels, jewelsById, activeBuild, savedBuilds, computeStats };
})();
