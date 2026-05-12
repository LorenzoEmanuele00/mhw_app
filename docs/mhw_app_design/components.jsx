// Loadout — shared UI primitives (icons, badges, slots, bars, sheet)
// All components read theme via props or window.useTheme()

// ─────────────────────────────────────────────────────────────
// Theme tokens
// ─────────────────────────────────────────────────────────────
const THEMES = {
  light: {
    bg: '#F2F2F7', card: '#FFFFFF', card2: '#F2F2F7',
    label: '#000000', label2: 'rgba(60,60,67,0.6)', label3: 'rgba(60,60,67,0.3)',
    sep: 'rgba(60,60,67,0.12)', fill: 'rgba(120,120,128,0.16)',
    chip: 'rgba(120,120,128,0.12)',
    overlay: 'rgba(0,0,0,0.4)',
    barTrack: 'rgba(120,120,128,0.18)',
    tabBar: 'rgba(249,249,249,0.78)',
  },
  dark: {
    bg: '#000000', card: '#1C1C1E', card2: '#2C2C2E',
    label: '#FFFFFF', label2: 'rgba(235,235,245,0.6)', label3: 'rgba(235,235,245,0.3)',
    sep: 'rgba(84,84,88,0.65)', fill: 'rgba(118,118,128,0.24)',
    chip: 'rgba(118,118,128,0.32)',
    overlay: 'rgba(0,0,0,0.6)',
    barTrack: 'rgba(120,120,128,0.32)',
    tabBar: 'rgba(22,22,23,0.78)',
  },
};

const ACCENTS = {
  blue:   { light: '#007AFF', dark: '#0A84FF' },
  orange: { light: '#FF6A3D', dark: '#FF7A55' },
  green:  { light: '#34C759', dark: '#30D158' },
  purple: { light: '#AF52DE', dark: '#BF5AF2' },
  graphite: { light: '#1d1d1f', dark: '#e8e6df' },
};

const ELEMENT_COLORS = {
  fire:    { light: '#FF6A3D', dark: '#FF7A55' },
  water:   { light: '#0A84FF', dark: '#3098FF' },
  thunder: { light: '#E0A100', dark: '#FFCC00' },
  ice:     { light: '#5AC8FA', dark: '#64D2FF' },
  dragon:  { light: '#7A5AE0', dark: '#9D7FF0' },
};

const SKILL_COLORS = {
  red:    { light: '#FF3B30', dark: '#FF453A' },
  orange: { light: '#FF9500', dark: '#FF9F0A' },
  green:  { light: '#34C759', dark: '#30D158' },
  blue:   { light: '#007AFF', dark: '#0A84FF' },
  cyan:   { light: '#5AC8FA', dark: '#64D2FF' },
  purple: { light: '#AF52DE', dark: '#BF5AF2' },
  gray:   { light: '#8E8E93', dark: '#98989D' },
};

// ─────────────────────────────────────────────────────────────
// Equipment slot glyphs (original abstract shapes)
// ─────────────────────────────────────────────────────────────
const SLOT_KINDS = [
  { key: 'weapon', label: 'Weapon' },
  { key: 'head',   label: 'Head' },
  { key: 'chest',  label: 'Chest' },
  { key: 'arms',   label: 'Arms' },
  { key: 'waist',  label: 'Waist' },
  { key: 'legs',   label: 'Legs' },
  { key: 'charm',  label: 'Charm' },
];

function SlotGlyph({ kind, size = 22, color = '#fff' }) {
  const s = size;
  const stroke = { fill: 'none', stroke: color, strokeWidth: 1.6, strokeLinejoin: 'round', strokeLinecap: 'round' };
  const paths = {
    weapon: <polygon points="3,17 13,3 17,7 7,21" {...stroke} />,
    head:   <path d="M5 14 C5 8, 8 4, 12 4 C16 4, 19 8, 19 14 L19 17 L5 17 Z" {...stroke} />,
    chest:  <path d="M5 6 L9 4 L12 7 L15 4 L19 6 L19 18 L5 18 Z" {...stroke} />,
    arms:   <path d="M5 6 L19 6 L19 14 L17 18 L7 18 L5 14 Z" {...stroke} />,
    waist:  <path d="M4 9 L20 9 L20 15 L4 15 Z M11 9 L11 15 M13 9 L13 15" {...stroke} />,
    legs:   <path d="M7 4 L17 4 L19 20 L14 20 L12 12 L10 20 L5 20 Z" {...stroke} />,
    charm:  <path d="M12 3 L20 12 L12 21 L4 12 Z" {...stroke} />,
  };
  return (
    <svg width={s} height={s} viewBox="0 0 24 24">{paths[kind] || paths.charm}</svg>
  );
}

// ─────────────────────────────────────────────────────────────
// Utility: tab icons
// ─────────────────────────────────────────────────────────────
function TabIcon({ name, active, color }) {
  const s = 26, sw = active ? 2.2 : 1.8;
  const props = { fill: 'none', stroke: color, strokeWidth: sw, strokeLinejoin: 'round', strokeLinecap: 'round' };
  const fillProps = { fill: color };
  if (name === 'build') {
    // 7-slot constellation — outer hex with center dot
    return (
      <svg width={s} height={s} viewBox="0 0 24 24">
        {active ? (
          <g>
            <circle cx="12" cy="4"  r="2" {...fillProps} />
            <circle cx="20" cy="8"  r="2" {...fillProps} />
            <circle cx="20" cy="16" r="2" {...fillProps} />
            <circle cx="12" cy="20" r="2" {...fillProps} />
            <circle cx="4"  cy="16" r="2" {...fillProps} />
            <circle cx="4"  cy="8"  r="2" {...fillProps} />
            <circle cx="12" cy="12" r="2.4" {...fillProps} />
          </g>
        ) : (
          <g>
            <circle cx="12" cy="4"  r="1.6" {...props} />
            <circle cx="20" cy="8"  r="1.6" {...props} />
            <circle cx="20" cy="16" r="1.6" {...props} />
            <circle cx="12" cy="20" r="1.6" {...props} />
            <circle cx="4"  cy="16" r="1.6" {...props} />
            <circle cx="4"  cy="8"  r="1.6" {...props} />
            <circle cx="12" cy="12" r="2" {...props} />
          </g>
        )}
      </svg>
    );
  }
  if (name === 'equipment') {
    return (
      <svg width={s} height={s} viewBox="0 0 24 24">
        <rect x="3.5" y="3.5" width="7" height="7"  rx="1.5" {...(active ? fillProps : props)} />
        <rect x="13.5" y="3.5" width="7" height="7" rx="1.5" {...props} />
        <rect x="3.5" y="13.5" width="7" height="7" rx="1.5" {...props} />
        <rect x="13.5" y="13.5" width="7" height="7" rx="1.5" {...(active ? fillProps : props)} />
      </svg>
    );
  }
  if (name === 'stats') {
    return (
      <svg width={s} height={s} viewBox="0 0 24 24">
        <rect x="4"  y="13" width="3.5" height="7"  rx="1" {...(active ? fillProps : props)} />
        <rect x="10" y="9"  width="3.5" height="11" rx="1" {...(active ? fillProps : props)} />
        <rect x="16" y="5"  width="3.5" height="15" rx="1" {...(active ? fillProps : props)} />
      </svg>
    );
  }
  if (name === 'saved') {
    return (
      <svg width={s} height={s} viewBox="0 0 24 24">
        <path d="M6 3 L18 3 L18 21 L12 17 L6 21 Z" {...(active ? fillProps : props)} />
      </svg>
    );
  }
  return null;
}

// ─────────────────────────────────────────────────────────────
// Glyph tile — used for equipment thumbnails
// ─────────────────────────────────────────────────────────────
function GlyphTile({ kind, size = 56, accent, theme, rounded = 14 }) {
  const t = THEMES[theme];
  return (
    <div style={{
      width: size, height: size, borderRadius: rounded,
      background: theme === 'dark' ? `${accent}24` : `${accent}1A`,
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      flexShrink: 0,
      border: `0.5px solid ${theme === 'dark' ? `${accent}30` : `${accent}26`}`,
    }}>
      <SlotGlyph kind={kind} size={Math.round(size * 0.5)} color={accent} />
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Decoration slot (gem holes)
// ─────────────────────────────────────────────────────────────
function DecoSlot({ level = 1, filled = false, theme, accent, size = 14 }) {
  const t = THEMES[theme];
  const empty = theme === 'dark' ? 'rgba(118,118,128,0.32)' : 'rgba(120,120,128,0.22)';
  const color = filled ? accent : empty;
  if (level === 1) {
    return <div style={{ width: size, height: size, borderRadius: 999, border: `1.4px solid ${color}` }} />;
  }
  if (level === 2) {
    return <div style={{ width: size, height: size, border: `1.4px solid ${color}`, transform: 'rotate(45deg)' }} />;
  }
  return (
    <svg width={size + 2} height={size + 2} viewBox="0 0 16 16">
      <polygon points="8,1 15,8 8,15 1,8" fill="none" stroke={color} strokeWidth="1.6" />
    </svg>
  );
}

function DecoSlotsRow({ slots, theme, accent }) {
  if (!slots || slots.length === 0) {
    return <span style={{ fontSize: 13, color: THEMES[theme].label3 }}>—</span>;
  }
  return (
    <div style={{ display: 'flex', gap: 4, alignItems: 'center' }}>
      {slots.map((lv, i) => <DecoSlot key={i} level={lv} theme={theme} accent={accent} />)}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Skill chip
// ─────────────────────────────────────────────────────────────
function SkillChip({ name, level, theme, max }) {
  const t = THEMES[theme];
  const sk = window.LOADOUT_DATA.skills[name];
  const c = sk ? SKILL_COLORS[sk.color][theme] : t.label2;
  const cap = max ?? sk?.max ?? level;
  return (
    <div style={{
      display: 'inline-flex', alignItems: 'center', gap: 6,
      padding: '5px 10px 5px 8px', borderRadius: 999,
      background: theme === 'dark' ? `${c}24` : `${c}18`,
      fontSize: 13, fontWeight: 590, color: c,
      letterSpacing: -0.08,
    }}>
      <span style={{ width: 6, height: 6, borderRadius: 999, background: c }} />
      {name}
      <span style={{
        fontVariantNumeric: 'tabular-nums', opacity: 0.85,
        fontWeight: 500, letterSpacing: 0,
      }}>{level}/{cap}</span>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Stat bar
// ─────────────────────────────────────────────────────────────
function StatBar({ label, value, max, color, theme, suffix = '', signed = false }) {
  const t = THEMES[theme];
  const pct = Math.max(0, Math.min(1, Math.abs(value) / max));
  const isNeg = signed && value < 0;
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
      <div style={{
        display: 'flex', justifyContent: 'space-between', alignItems: 'baseline',
        fontSize: 14, color: t.label2, letterSpacing: -0.08,
      }}>
        <span style={{ fontWeight: 500 }}>{label}</span>
        <span style={{
          fontVariantNumeric: 'tabular-nums', fontWeight: 600,
          color: isNeg ? SKILL_COLORS.red[theme] : t.label,
        }}>{signed && value > 0 ? '+' : ''}{value}{suffix}</span>
      </div>
      <div style={{
        height: 6, borderRadius: 999, background: t.barTrack, position: 'relative', overflow: 'hidden',
      }}>
        {signed ? (
          <div style={{
            position: 'absolute', top: 0, bottom: 0,
            left: isNeg ? `${50 - pct * 50}%` : '50%',
            width: `${pct * 50}%`,
            background: isNeg ? SKILL_COLORS.red[theme] : color,
            borderRadius: 999,
            transition: 'all 240ms cubic-bezier(.2,.8,.2,1)',
          }} />
        ) : (
          <div style={{
            height: '100%', width: `${pct * 100}%`, background: color, borderRadius: 999,
            transition: 'width 240ms cubic-bezier(.2,.8,.2,1)',
          }} />
        )}
        {signed && (
          <div style={{ position: 'absolute', top: -2, bottom: -2, left: '50%', width: 1, background: t.label3 }} />
        )}
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Card / Section
// ─────────────────────────────────────────────────────────────
function Card({ children, theme, style, padding = 16, onClick }) {
  const t = THEMES[theme];
  return (
    <div onClick={onClick} style={{
      background: t.card, borderRadius: 18, padding, ...style,
      cursor: onClick ? 'default' : undefined,
    }}>{children}</div>
  );
}

function SectionLabel({ children, theme, action, onAction }) {
  const t = THEMES[theme];
  return (
    <div style={{
      display: 'flex', alignItems: 'baseline', justifyContent: 'space-between',
      padding: '0 4px 8px',
    }}>
      <div style={{
        fontSize: 13, fontWeight: 600, color: t.label2,
        textTransform: 'uppercase', letterSpacing: 0.6,
      }}>{children}</div>
      {action && (
        <button onClick={onAction} style={{
          appearance: 'none', border: 0, background: 'transparent',
          fontSize: 15, fontWeight: 500, color: t.accent || '#0A84FF',
          padding: 0, cursor: 'default',
        }}>{action}</button>
      )}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Sheet (slide-up modal)
// ─────────────────────────────────────────────────────────────
function Sheet({ open, onClose, theme, children, height = '88%' }) {
  const t = THEMES[theme];
  return (
    <div style={{
      position: 'absolute', inset: 0, zIndex: 100,
      pointerEvents: open ? 'auto' : 'none',
    }}>
      <div onClick={onClose} style={{
        position: 'absolute', inset: 0,
        background: t.overlay, opacity: open ? 1 : 0,
        transition: 'opacity 260ms cubic-bezier(.2,.8,.2,1)',
      }} />
      <div style={{
        position: 'absolute', left: 0, right: 0, bottom: 0,
        height, borderRadius: '14px 14px 0 0',
        background: theme === 'dark' ? '#1C1C1E' : '#F2F2F7',
        transform: open ? 'translateY(0)' : 'translateY(100%)',
        transition: 'transform 320ms cubic-bezier(.2,.85,.2,1)',
        display: 'flex', flexDirection: 'column',
        boxShadow: '0 -10px 30px rgba(0,0,0,0.18)',
      }}>
        <div style={{
          alignSelf: 'center', width: 36, height: 5, borderRadius: 999,
          background: t.label3, margin: '8px 0 4px',
        }} />
        <div style={{ flex: 1, overflow: 'auto' }}>{children}</div>
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Segmented control
// ─────────────────────────────────────────────────────────────
function Segmented({ options, value, onChange, theme }) {
  const t = THEMES[theme];
  const idx = options.findIndex(o => (o.value ?? o) === value);
  return (
    <div style={{
      display: 'flex', position: 'relative', padding: 2,
      background: t.fill, borderRadius: 9,
      fontSize: 13, fontWeight: 590, letterSpacing: -0.08,
    }}>
      <div style={{
        position: 'absolute', top: 2, bottom: 2,
        width: `calc((100% - 4px) / ${options.length})`,
        left: `calc(2px + (100% - 4px) / ${options.length} * ${idx})`,
        background: theme === 'dark' ? '#636366' : '#fff',
        borderRadius: 7,
        boxShadow: '0 3px 8px rgba(0,0,0,0.12), 0 1px 1px rgba(0,0,0,0.04)',
        transition: 'left 240ms cubic-bezier(.2,.8,.2,1)',
      }} />
      {options.map((o, i) => {
        const v = o.value ?? o; const l = o.label ?? o;
        return (
          <button key={v} onClick={() => onChange(v)} style={{
            flex: 1, position: 'relative', zIndex: 1,
            appearance: 'none', border: 0, background: 'transparent',
            padding: '6px 8px', cursor: 'default',
            color: t.label, fontWeight: idx === i ? 600 : 500,
          }}>{l}</button>
        );
      })}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Equipment row (used in lists)
// ─────────────────────────────────────────────────────────────
function EquipmentRow({ item, theme, accent, onClick, equipped = false, isLast = false }) {
  const t = THEMES[theme];
  const main = item.kind === 'weapon'
    ? `${item.attack} ATK${item.affinity ? ` · ${item.affinity > 0 ? '+' : ''}${item.affinity}%` : ''}`
    : item.kind === 'charm'
      ? `Rarity ${item.rarity}`
      : `${item.defense} DEF`;
  return (
    <div onClick={onClick} style={{
      display: 'flex', alignItems: 'center', gap: 12,
      padding: '12px 14px', cursor: 'default',
      borderBottom: isLast ? 'none' : `0.5px solid ${t.sep}`,
    }}>
      <GlyphTile kind={item.kind} size={44} accent={accent} theme={theme} rounded={11} />
      <div style={{ flex: 1, minWidth: 0 }}>
        <div style={{
          display: 'flex', gap: 8, alignItems: 'center',
        }}>
          <div style={{
            fontSize: 16, fontWeight: 590, color: t.label,
            letterSpacing: -0.32,
            whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis',
          }}>{item.name}</div>
          {equipped && (
            <span style={{
              fontSize: 11, fontWeight: 700, color: accent,
              background: theme === 'dark' ? `${accent}24` : `${accent}1A`,
              padding: '2px 6px', borderRadius: 5, letterSpacing: 0.4,
              textTransform: 'uppercase',
            }}>Equipped</span>
          )}
        </div>
        <div style={{
          display: 'flex', gap: 8, alignItems: 'center', marginTop: 2,
          fontSize: 13, color: t.label2, letterSpacing: -0.08,
        }}>
          <span>{main}</span>
          {item.type && <><span>·</span><span>{item.type}</span></>}
          {item.element && (
            <><span>·</span>
              <span style={{ color: ELEMENT_COLORS[item.element.type][theme], textTransform: 'capitalize' }}>
                {item.element.type} {item.element.value}
              </span>
            </>
          )}
        </div>
      </div>
      <DecoSlotsRow slots={item.slots} theme={theme} accent={accent} />
      <svg width="8" height="14" viewBox="0 0 8 14" style={{ marginLeft: 4, flexShrink: 0 }}>
        <path d="M1 1l6 6-6 6" stroke={t.label3} strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round" />
      </svg>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Tab bar
// ─────────────────────────────────────────────────────────────
function TabBar({ tab, onChange, theme, accent }) {
  const t = THEMES[theme];
  const tabs = [
    { key: 'build',     label: 'Build' },
    { key: 'equipment', label: 'Equipment' },
    { key: 'stats',     label: 'Stats' },
    { key: 'saved',     label: 'Loadouts' },
  ];
  return (
    <div style={{
      position: 'absolute', left: 0, right: 0, bottom: 0,
      paddingBottom: 24, paddingTop: 8,
      background: t.tabBar,
      backdropFilter: 'blur(20px) saturate(180%)',
      WebkitBackdropFilter: 'blur(20px) saturate(180%)',
      borderTop: `0.5px solid ${t.sep}`,
      display: 'flex', alignItems: 'flex-start', justifyContent: 'space-around',
      zIndex: 30,
    }}>
      {tabs.map(({ key, label }) => {
        const active = tab === key;
        const color = active ? accent : t.label2;
        return (
          <button key={key} onClick={() => onChange(key)} style={{
            appearance: 'none', border: 0, background: 'transparent',
            display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 3,
            padding: '4px 12px', cursor: 'default', flex: 1,
          }}>
            <TabIcon name={key} active={active} color={color} />
            <span style={{
              fontSize: 10, fontWeight: 500, color,
              letterSpacing: 0.1,
            }}>{label}</span>
          </button>
        );
      })}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Resistance radar
// ─────────────────────────────────────────────────────────────
function ResistanceRadar({ res, theme, size = 200 }) {
  const t = THEMES[theme];
  const elems = ['fire', 'water', 'thunder', 'ice', 'dragon'];
  const cx = size / 2, cy = size / 2;
  const r = size / 2 - 28;
  const angle = (i) => -Math.PI / 2 + (i * 2 * Math.PI) / elems.length;
  const point = (i, mag) => {
    const a = angle(i);
    return [cx + Math.cos(a) * r * mag, cy + Math.sin(a) * r * mag];
  };
  const norm = (v) => 0.5 + Math.max(-1, Math.min(1, v / 20)) * 0.5;
  const poly = elems.map((e, i) => point(i, norm(res[e]))).map(p => p.join(',')).join(' ');
  const ringPoly = (m) => elems.map((_, i) => point(i, m)).map(p => p.join(',')).join(' ');

  return (
    <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`}>
      {[0.25, 0.5, 0.75, 1].map((m, i) => (
        <polygon key={i} points={ringPoly(m)} fill="none"
          stroke={t.sep} strokeWidth={i === 3 ? 1 : 0.5} />
      ))}
      {elems.map((e, i) => {
        const [x, y] = point(i, 1);
        return <line key={e} x1={cx} y1={cy} x2={x} y2={y} stroke={t.sep} strokeWidth="0.5" />;
      })}
      <polygon points={poly} fill={`${SKILL_COLORS.blue[theme]}30`} stroke={SKILL_COLORS.blue[theme]} strokeWidth="1.6" strokeLinejoin="round" />
      {elems.map((e, i) => {
        const a = angle(i);
        const lx = cx + Math.cos(a) * (r + 16);
        const ly = cy + Math.sin(a) * (r + 16) + 4;
        return (
          <g key={e}>
            <text x={lx} y={ly} textAnchor="middle" fontSize="11" fontWeight="600"
              fill={ELEMENT_COLORS[e][theme]} style={{ textTransform: 'capitalize' }}>{e}</text>
            <text x={lx} y={ly + 12} textAnchor="middle" fontSize="10" fontWeight="500" fill={t.label2}
              style={{ fontVariantNumeric: 'tabular-nums' }}>
              {res[e] > 0 ? '+' : ''}{res[e]}
            </text>
          </g>
        );
      })}
    </svg>
  );
}

// ─────────────────────────────────────────────────────────────
// Sharpness gauge (simple bar)
// ─────────────────────────────────────────────────────────────
function SharpnessGauge({ value, theme }) {
  const segs = [
    { color: '#FF453A', size: 0.05 },
    { color: '#FF9F0A', size: 0.10 },
    { color: '#FFD60A', size: 0.10 },
    { color: '#30D158', size: 0.20 },
    { color: '#0A84FF', size: 0.20 },
    { color: '#F2F2F7', size: 0.20 },
    { color: '#BF5AF2', size: 0.15 },
  ];
  const t = THEMES[theme];
  return (
    <div style={{
      display: 'flex', height: 10, borderRadius: 4, overflow: 'hidden',
      background: t.barTrack, position: 'relative',
    }}>
      {segs.map((s, i) => {
        const start = segs.slice(0, i).reduce((a, c) => a + c.size, 0);
        const filledStart = Math.max(0, Math.min(s.size, value - start));
        return (
          <div key={i} style={{
            flex: s.size, position: 'relative',
            background: theme === 'dark' ? `${s.color}40` : `${s.color}30`,
          }}>
            <div style={{
              position: 'absolute', top: 0, bottom: 0, left: 0,
              width: `${(filledStart / s.size) * 100}%`,
              background: s.color,
            }} />
          </div>
        );
      })}
    </div>
  );
}

Object.assign(window, {
  THEMES, ACCENTS, ELEMENT_COLORS, SKILL_COLORS, SLOT_KINDS,
  SlotGlyph, GlyphTile, DecoSlot, DecoSlotsRow, SkillChip, StatBar,
  Card, SectionLabel, Sheet, Segmented, EquipmentRow, TabBar,
  TabIcon, ResistanceRadar, SharpnessGauge,
});
