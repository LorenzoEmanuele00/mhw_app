// Loadout — main screens
// Reads from window.* primitives + window.LOADOUT_DATA

const LD = window.LOADOUT_DATA;

// ─────────────────────────────────────────────────────────────
// Screen scaffolding
// ─────────────────────────────────────────────────────────────
function Screen({ theme, children, scrollKey }) {
  // wrapper that takes the full device interior, scrolls, leaves room for tab bar
  const t = THEMES[theme];
  return (
    <div style={{
      position: 'absolute', inset: 0,
      background: t.bg,
      overflowY: 'auto', overflowX: 'hidden',
      paddingTop: 52, paddingBottom: 100,
      WebkitOverflowScrolling: 'touch',
    }} key={scrollKey}>
      {children}
    </div>
  );
}

function LargeTitle({ title, subtitle, trailing, theme, leading }) {
  const t = THEMES[theme];
  return (
    <div style={{ padding: '8px 20px 16px', position: 'relative' }}>
      <div style={{
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        marginBottom: subtitle ? 6 : 0,
        minHeight: 32,
      }}>
        {leading || <div />}
        {trailing}
      </div>
      <div style={{
        fontSize: 34, fontWeight: 700, letterSpacing: 0.4,
        color: t.label, lineHeight: '41px',
      }}>{title}</div>
      {subtitle && (
        <div style={{
          marginTop: 2, fontSize: 15, color: t.label2, letterSpacing: -0.24,
        }}>{subtitle}</div>
      )}
    </div>
  );
}

function HeaderButton({ children, onClick, theme, primary }) {
  const t = THEMES[theme];
  return (
    <button onClick={onClick} style={{
      appearance: 'none', border: 0,
      background: 'transparent',
      fontSize: 17, fontWeight: primary ? 600 : 400,
      color: t.accent || '#0A84FF',
      cursor: 'default',
      padding: '4px 0',
      letterSpacing: -0.43,
    }}>{children}</button>
  );
}

// Padded section
function Stack({ children, theme, gap = 28, padding = 16 }) {
  return (
    <div style={{
      display: 'flex', flexDirection: 'column', gap,
      padding: `0 ${padding}px`,
    }}>{children}</div>
  );
}

// ─────────────────────────────────────────────────────────────
// Build screen
// ─────────────────────────────────────────────────────────────
function WeaponHero({ weapon, theme, accent, onClick }) {
  const t = THEMES[theme];
  if (!weapon) {
    return (
      <div onClick={onClick} style={{
        padding: 20, borderRadius: 18, background: t.card,
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        flexDirection: 'column', gap: 8, minHeight: 160,
        border: `1px dashed ${t.label3}`, cursor: 'default',
      }}>
        <SlotGlyph kind="weapon" color={t.label3} size={32} />
        <span style={{ color: t.label2, fontSize: 15 }}>No weapon equipped</span>
      </div>
    );
  }
  return (
    <div onClick={onClick} style={{
      borderRadius: 22, background: t.card, overflow: 'hidden',
      position: 'relative', cursor: 'default',
    }}>
      <div style={{
        padding: '18px 18px 16px',
        display: 'flex', alignItems: 'flex-start', gap: 14,
      }}>
        <GlyphTile kind="weapon" size={64} accent={accent} theme={theme} rounded={16} />
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{
            fontSize: 11, fontWeight: 700, letterSpacing: 0.6,
            color: t.label2, textTransform: 'uppercase',
            display: 'flex', alignItems: 'center', gap: 8,
          }}>
            {weapon.type}
            <span style={{
              display: 'inline-flex', alignItems: 'center',
              padding: '1px 5px', borderRadius: 4,
              background: theme === 'dark' ? `${accent}24` : `${accent}1A`,
              color: accent, letterSpacing: 0.3,
            }}>R{weapon.rarity}</span>
          </div>
          <div style={{
            fontSize: 22, fontWeight: 700, color: t.label,
            letterSpacing: -0.4, marginTop: 2, lineHeight: 1.15,
          }}>{weapon.name}</div>
          <div style={{ marginTop: 8 }}>
            <DecoSlotsRow slots={weapon.slots} theme={theme} accent={accent} />
          </div>
        </div>
      </div>
      {/* Stats grid */}
      <div style={{
        display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)',
        borderTop: `0.5px solid ${t.sep}`,
      }}>
        {[
          { label: 'Attack',   value: weapon.attack,    color: t.label },
          { label: 'Affinity', value: `${weapon.affinity > 0 ? '+' : ''}${weapon.affinity}%`, color: weapon.affinity < 0 ? SKILL_COLORS.red[theme] : t.label },
          { label: 'Element',
            value: weapon.element ? `${weapon.element.value}` : '—',
            color: weapon.element ? ELEMENT_COLORS[weapon.element.type][theme] : t.label2,
            sub: weapon.element ? weapon.element.type : null },
        ].map((s, i) => (
          <div key={s.label} style={{
            padding: '12px 8px 14px',
            borderRight: i < 2 ? `0.5px solid ${t.sep}` : 'none',
            textAlign: 'center',
          }}>
            <div style={{
              fontSize: 11, fontWeight: 600, letterSpacing: 0.3,
              color: t.label2, textTransform: 'uppercase',
            }}>{s.label}</div>
            <div style={{
              fontSize: 22, fontWeight: 700, marginTop: 2,
              color: s.color, fontVariantNumeric: 'tabular-nums',
              letterSpacing: -0.4,
            }}>{s.value}</div>
            {s.sub && (
              <div style={{
                fontSize: 11, color: t.label2, textTransform: 'capitalize',
                marginTop: 1, fontWeight: 500,
              }}>{s.sub}</div>
            )}
          </div>
        ))}
      </div>
      {/* Sharpness */}
      <div style={{ padding: '12px 18px 18px' }}>
        <div style={{
          display: 'flex', justifyContent: 'space-between',
          fontSize: 11, fontWeight: 600, letterSpacing: 0.3,
          color: t.label2, textTransform: 'uppercase', marginBottom: 6,
        }}>
          <span>Sharpness</span>
        </div>
        <SharpnessGauge value={weapon.sharpness} theme={theme} />
      </div>
    </div>
  );
}

function ArmorSlotRow({ kind, item, theme, accent, onClick, isLast }) {
  const t = THEMES[theme];
  const label = SLOT_KINDS.find(s => s.key === kind)?.label;
  return (
    <div onClick={onClick} style={{
      display: 'flex', alignItems: 'center', gap: 12,
      padding: '12px 14px', cursor: 'default',
      borderBottom: isLast ? 'none' : `0.5px solid ${t.sep}`,
    }}>
      <GlyphTile kind={kind} size={42} accent={item ? accent : t.label3} theme={theme} rounded={11} />
      <div style={{ flex: 1, minWidth: 0 }}>
        <div style={{
          fontSize: 11, fontWeight: 600, letterSpacing: 0.3,
          color: t.label2, textTransform: 'uppercase',
        }}>{label}</div>
        {item ? (
          <div style={{
            fontSize: 16, fontWeight: 590, color: t.label,
            letterSpacing: -0.32, marginTop: 1,
            whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis',
          }}>{item.name}</div>
        ) : (
          <div style={{
            fontSize: 16, fontWeight: 500, color: t.label2,
            letterSpacing: -0.32, marginTop: 1,
          }}>Empty slot</div>
        )}
      </div>
      {item && item.defense !== undefined && (
        <div style={{
          textAlign: 'right',
          fontSize: 13, color: t.label2, letterSpacing: -0.08,
          fontVariantNumeric: 'tabular-nums',
        }}>
          <div style={{ fontWeight: 590, color: t.label }}>{item.defense}</div>
          <div style={{ fontSize: 10, opacity: 0.7 }}>DEF</div>
        </div>
      )}
      <DecoSlotsRow slots={item?.slots || []} theme={theme} accent={accent} />
      <svg width="8" height="14" viewBox="0 0 8 14" style={{ marginLeft: 2, flexShrink: 0 }}>
        <path d="M1 1l6 6-6 6" stroke={t.label3} strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round"/>
      </svg>
    </div>
  );
}

function BuildScreen({ theme, accent, build, dispatch }) {
  const t = THEMES[theme];
  const stats = LD.computeStats(build);
  const weapon = LD.byId[build.slots.weapon];
  const armorKinds = ['head', 'chest', 'arms', 'waist', 'legs'];
  const charm = LD.byId[build.slots.charm];

  const skillChips = Object.entries(stats.skills)
    .sort((a, b) => b[1] - a[1])
    .map(([n, l]) => <SkillChip key={n} name={n} level={l} theme={theme} />);

  return (
    <Screen theme={theme}>
      <LargeTitle
        title="Build"
        subtitle={build.name}
        theme={theme}
      />

      <Stack theme={theme}>
        <div>
          <SectionLabel theme={theme}>Weapon</SectionLabel>
          <WeaponHero weapon={weapon} theme={theme} accent={accent}
            onClick={() => weapon
              ? dispatch({ type: 'openItem', id: weapon.id })
              : dispatch({ type: 'pickSlot', kind: 'weapon' })} />
        </div>

        <div>
          <SectionLabel theme={theme}>Armor</SectionLabel>
          <Card theme={theme} padding={0}>
            {armorKinds.map((k, i) => {
              const it = LD.byId[build.slots[k]];
              return (
                <ArmorSlotRow
                  key={k} kind={k} item={it}
                  theme={theme} accent={accent}
                  onClick={() => it
                    ? dispatch({ type: 'openItem', id: it.id })
                    : dispatch({ type: 'pickSlot', kind: k })}
                  isLast={i === armorKinds.length - 1}
                />
              );
            })}
          </Card>
        </div>

        <div>
          <SectionLabel theme={theme}>Charm</SectionLabel>
          <Card theme={theme} padding={0}>
            <ArmorSlotRow
              kind="charm" item={charm}
              theme={theme} accent={accent}
              onClick={() => charm
                ? dispatch({ type: 'openItem', id: charm.id })
                : dispatch({ type: 'pickSlot', kind: 'charm' })}
              isLast
            />
          </Card>
        </div>

        <div>
          <SectionLabel theme={theme} action="See all" onAction={() => dispatch({ type: 'tab', tab: 'stats' })}>
            Active Skills
          </SectionLabel>
          <Card theme={theme}>
            {skillChips.length ? (
              <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6 }}>{skillChips}</div>
            ) : (
              <div style={{ color: t.label2, fontSize: 14 }}>No skills active.</div>
            )}
          </Card>
        </div>

        <div>
          <SectionLabel theme={theme} action="View stats" onAction={() => dispatch({ type: 'tab', tab: 'stats' })}>
            Quick Summary
          </SectionLabel>
          <Card theme={theme}>
            <div style={{
              display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)',
              gap: '14px 24px',
            }}>
              <SummaryStat label="Attack"   value={stats.attack} theme={theme} />
              <SummaryStat label="Defense"  value={stats.defense} theme={theme} />
              <SummaryStat label="Affinity" value={`${stats.affinity > 0 ? '+' : ''}${stats.affinity}%`} theme={theme} 
                color={stats.affinity < 0 ? SKILL_COLORS.red[theme] : null} />
              <SummaryStat label="Element"
                value={stats.element ? stats.element.value : '—'}
                sub={stats.element?.type}
                color={stats.element ? ELEMENT_COLORS[stats.element.type][theme] : null}
                theme={theme} />
            </div>
          </Card>
        </div>
      </Stack>
    </Screen>
  );
}

function SummaryStat({ label, value, sub, color, theme }) {
  const t = THEMES[theme];
  return (
    <div>
      <div style={{
        fontSize: 11, fontWeight: 600, letterSpacing: 0.3,
        color: t.label2, textTransform: 'uppercase',
      }}>{label}</div>
      <div style={{
        fontSize: 24, fontWeight: 700, marginTop: 2,
        color: color || t.label, fontVariantNumeric: 'tabular-nums',
        letterSpacing: -0.4,
      }}>{value}</div>
      {sub && (
        <div style={{
          fontSize: 11, color: t.label2, textTransform: 'capitalize',
          marginTop: 0, fontWeight: 500,
        }}>{sub}</div>
      )}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Equipment screen
// ─────────────────────────────────────────────────────────────
function SearchField({ value, onChange, theme, placeholder = 'Search' }) {
  const t = THEMES[theme];
  return (
    <div style={{
      display: 'flex', alignItems: 'center', gap: 6,
      padding: '0 8px', height: 36, borderRadius: 10,
      background: t.fill,
      margin: '0 16px',
    }}>
      <svg width="14" height="14" viewBox="0 0 16 16" style={{ flexShrink: 0 }}>
        <circle cx="7" cy="7" r="5" fill="none" stroke={t.label2} strokeWidth="1.6" />
        <line x1="11" y1="11" x2="14" y2="14" stroke={t.label2} strokeWidth="1.6" strokeLinecap="round" />
      </svg>
      <input value={value} onChange={(e) => onChange(e.target.value)} placeholder={placeholder} style={{
        flex: 1, appearance: 'none', border: 0, background: 'transparent',
        outline: 'none', color: t.label,
        fontSize: 17, letterSpacing: -0.43,
        fontFamily: 'inherit',
      }} />
    </div>
  );
}

function EquipmentScreen({ theme, accent, build, dispatch, initialCategory = 'weapons' }) {
  const t = THEMES[theme];
  const [category, setCategory] = React.useState(initialCategory);
  const [query, setQuery] = React.useState('');

  const armorKinds = ['head', 'chest', 'arms', 'waist', 'legs'];
  let items = [];
  if (category === 'weapons') items = LD.weapons;
  else if (category === 'armor') items = armorKinds.flatMap(k => LD[k]);
  else items = LD.charm;

  const filtered = items.filter(i => i.name.toLowerCase().includes(query.toLowerCase()));

  const equippedIds = new Set(Object.values(build.slots));

  const renderList = () => {
    if (category === 'armor') {
      // Group by kind
      return armorKinds.map(k => {
        const list = LD[k].filter(i => i.name.toLowerCase().includes(query.toLowerCase()));
        if (!list.length) return null;
        const label = SLOT_KINDS.find(s => s.key === k).label;
        return (
          <div key={k}>
            <SectionLabel theme={theme}>{label}</SectionLabel>
            <Card theme={theme} padding={0}>
              {list.map((item, i) => (
                <EquipmentRow key={item.id} item={item} theme={theme} accent={accent}
                  equipped={equippedIds.has(item.id)}
                  onClick={() => dispatch({ type: 'openItem', id: item.id })}
                  isLast={i === list.length - 1} />
              ))}
            </Card>
          </div>
        );
      });
    }
    return (
      <Card theme={theme} padding={0}>
        {filtered.map((item, i) => (
          <EquipmentRow key={item.id} item={item} theme={theme} accent={accent}
            equipped={equippedIds.has(item.id)}
            onClick={() => dispatch({ type: 'openItem', id: item.id })}
            isLast={i === filtered.length - 1} />
        ))}
        {!filtered.length && (
          <div style={{ padding: 24, textAlign: 'center', color: t.label2, fontSize: 14 }}>
            Nothing matches "{query}".
          </div>
        )}
      </Card>
    );
  };

  return (
    <Screen theme={theme} scrollKey={category}>
      <LargeTitle title="Equipment" theme={theme}
        subtitle={`${LD.all.length} items in catalog`}
        trailing={<HeaderButton theme={theme}>Filter</HeaderButton>} />

      <SearchField value={query} onChange={setQuery} theme={theme} />

      <div style={{ padding: '14px 16px 4px' }}>
        <Segmented theme={theme}
          value={category}
          onChange={setCategory}
          options={[
            { value: 'weapons', label: 'Weapons' },
            { value: 'armor',   label: 'Armor' },
            { value: 'charm',   label: 'Charm' },
          ]} />
      </div>

      <Stack theme={theme} gap={20}>
        {renderList()}
      </Stack>
    </Screen>
  );
}

// ─────────────────────────────────────────────────────────────
// Stats screen
// ─────────────────────────────────────────────────────────────
function StatsScreen({ theme, accent, build, statsView, dispatch }) {
  const t = THEMES[theme];
  const stats = LD.computeStats(build);
  const weapon = LD.byId[build.slots.weapon];

  const skillEntries = Object.entries(stats.skills).sort((a, b) => b[1] - a[1]);

  return (
    <Screen theme={theme}>
      <LargeTitle title="Stats" theme={theme}
        subtitle={build.name}
        trailing={<HeaderButton theme={theme} onClick={() => dispatch({ type: 'compare' })}>Compare</HeaderButton>} />

      <Stack theme={theme}>
        {/* Headline numbers */}
        <Card theme={theme}>
          <div style={{
            display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)',
            gap: 22,
          }}>
            <BigStat label="Attack" value={stats.attack} accent={SKILL_COLORS.red[theme]} theme={theme} />
            <BigStat label="Defense" value={stats.defense} accent={accent} theme={theme} />
            <BigStat label="Affinity"
              value={`${stats.affinity > 0 ? '+' : ''}${stats.affinity}%`}
              accent={stats.affinity < 0 ? SKILL_COLORS.red[theme] : SKILL_COLORS.orange[theme]}
              theme={theme} />
            <BigStat label="Element"
              value={stats.element ? stats.element.value : '—'}
              sub={stats.element?.type || 'none'}
              accent={stats.element ? ELEMENT_COLORS[stats.element.type][theme] : t.label2}
              theme={theme} />
          </div>
        </Card>

        {/* Sharpness */}
        {weapon && (
          <div>
            <SectionLabel theme={theme}>Sharpness</SectionLabel>
            <Card theme={theme}>
              <SharpnessGauge value={weapon.sharpness} theme={theme} />
              <div style={{
                display: 'flex', justifyContent: 'space-between',
                marginTop: 10,
                fontSize: 12, color: t.label2, letterSpacing: 0.2,
                textTransform: 'capitalize',
              }}>
                {['red','orange','yellow','green','blue','white','purple'].map(c => (
                  <span key={c}>{c}</span>
                ))}
              </div>
            </Card>
          </div>
        )}

        {/* Resistances */}
        <div>
          <SectionLabel theme={theme} action={statsView === 'radar' ? 'Bars' : 'Radar'}
            onAction={() => dispatch({ type: 'statsView', value: statsView === 'radar' ? 'bars' : 'radar' })}>
            Elemental Resistances
          </SectionLabel>
          <Card theme={theme}>
            {statsView === 'radar' ? (
              <div style={{ display: 'flex', justifyContent: 'center', padding: '6px 0' }}>
                <ResistanceRadar res={stats.res} theme={theme} size={260} />
              </div>
            ) : (
              <div style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
                {['fire', 'water', 'thunder', 'ice', 'dragon'].map(e => (
                  <StatBar key={e}
                    label={e.charAt(0).toUpperCase() + e.slice(1)}
                    value={stats.res[e]} max={20} signed
                    color={ELEMENT_COLORS[e][theme]} theme={theme} />
                ))}
              </div>
            )}
          </Card>
        </div>

        {/* Skills */}
        <div>
          <SectionLabel theme={theme}>Skills · {skillEntries.length}</SectionLabel>
          <Card theme={theme} padding={0}>
            {skillEntries.map(([name, lvl], i) => {
              const sk = LD.skills[name] || {};
              const c = SKILL_COLORS[sk.color || 'gray'][theme];
              const max = sk.max || lvl;
              return (
                <div key={name} style={{
                  padding: '14px 16px',
                  borderBottom: i === skillEntries.length - 1 ? 'none' : `0.5px solid ${t.sep}`,
                }}>
                  <div style={{
                    display: 'flex', justifyContent: 'space-between', alignItems: 'baseline',
                  }}>
                    <div style={{
                      fontSize: 16, fontWeight: 590, color: t.label, letterSpacing: -0.32,
                    }}>{name}</div>
                    <div style={{
                      fontSize: 14, fontWeight: 600, color: c,
                      fontVariantNumeric: 'tabular-nums',
                    }}>Lv {lvl}<span style={{ opacity: 0.5, fontWeight: 500 }}> / {max}</span></div>
                  </div>
                  {sk.desc && (
                    <div style={{ marginTop: 4, fontSize: 13, color: t.label2, letterSpacing: -0.08 }}>
                      {sk.desc}
                    </div>
                  )}
                  {/* level pips */}
                  <div style={{ display: 'flex', gap: 4, marginTop: 8 }}>
                    {Array.from({ length: max }).map((_, j) => (
                      <div key={j} style={{
                        flex: 1, height: 4, borderRadius: 2,
                        background: j < lvl ? c : t.barTrack,
                        transition: 'background 220ms',
                      }} />
                    ))}
                  </div>
                </div>
              );
            })}
            {!skillEntries.length && (
              <div style={{ padding: 20, textAlign: 'center', color: t.label2, fontSize: 14 }}>
                No skills active yet.
              </div>
            )}
          </Card>
        </div>

        {/* Decoration slots summary */}
        <div>
          <SectionLabel theme={theme}>Decoration Slots</SectionLabel>
          <Card theme={theme}>
            <div style={{
              display: 'flex', alignItems: 'center', justifyContent: 'space-between',
            }}>
              <div style={{ fontSize: 14, color: t.label2 }}>Total slots available</div>
              <DecoSlotsRow slots={stats.slots} theme={theme} accent={accent} />
            </div>
          </Card>
        </div>
      </Stack>
    </Screen>
  );
}

function BigStat({ label, value, sub, accent, theme }) {
  const t = THEMES[theme];
  return (
    <div>
      <div style={{
        fontSize: 12, fontWeight: 600, color: t.label2,
        letterSpacing: 0.3, textTransform: 'uppercase',
      }}>{label}</div>
      <div style={{
        fontSize: 32, fontWeight: 700, marginTop: 2,
        color: accent, fontVariantNumeric: 'tabular-nums',
        letterSpacing: -0.6, lineHeight: 1.1,
      }}>{value}</div>
      {sub && (
        <div style={{
          fontSize: 12, color: t.label2,
          textTransform: 'capitalize', marginTop: 2, fontWeight: 500,
        }}>{sub}</div>
      )}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Saved screen
// ─────────────────────────────────────────────────────────────
function SavedScreen({ theme, accent, build, savedBuilds, dispatch }) {
  const t = THEMES[theme];
  const [openId, setOpenId] = React.useState(null);
  const [confirmDelete, setConfirmDelete] = React.useState(null); // build object

  // Close any open swipe when tapping outside the list
  const closeAll = () => setOpenId(null);

  return (
    <Screen theme={theme}>
      <LargeTitle title="Loadouts" theme={theme}
        subtitle={`${savedBuilds.length} saved · swipe a card`}
        trailing={<HeaderButton theme={theme} primary onClick={() => dispatch({ type: 'newBuild' })}>+ New</HeaderButton>} />

      <Stack theme={theme} gap={12}>
        {savedBuilds.map(b => {
          const stats = LD.computeStats(b);
          const isActive = b.id === build.id;
          return (
            <SwipeableLoadoutRow
              key={b.id}
              id={b.id}
              theme={theme}
              accent={accent}
              isActive={isActive}
              openId={openId}
              setOpenId={setOpenId}
              onTap={() => dispatch({ type: 'loadBuild', id: b.id })}
              onEdit={() => {
                setOpenId(null);
                const next = window.prompt('Rename loadout', b.name);
                if (next && next.trim()) {
                  dispatch({ type: 'renameBuild', id: b.id, name: next.trim() });
                }
              }}
              onDelete={() => {
                setOpenId(null);
                setConfirmDelete(b);
              }}
            >
              <LoadoutCardBody build={b} stats={stats} isActive={isActive}
                theme={theme} accent={accent} />
            </SwipeableLoadoutRow>
          );
        })}
        {!savedBuilds.length && (
          <Card theme={theme}>
            <div style={{ color: t.label2, fontSize: 14, textAlign: 'center', padding: '8px 0' }}>
              No loadouts saved yet.
            </div>
          </Card>
        )}
      </Stack>

      <ConfirmDialog
        open={!!confirmDelete}
        theme={theme}
        title={confirmDelete ? `Delete "${confirmDelete.name}"?` : ''}
        message="This loadout will be permanently removed. This action cannot be undone."
        confirmLabel="Delete"
        destructive
        onCancel={() => setConfirmDelete(null)}
        onConfirm={() => {
          dispatch({ type: 'deleteBuild', id: confirmDelete.id });
          setConfirmDelete(null);
        }}
      />
    </Screen>
  );
}

// Static card body — extracted so the swipeable wrapper can host it.
function LoadoutCardBody({ build: b, stats, isActive, theme, accent }) {
  const t = THEMES[theme];
  return (
    <div style={{ padding: 16 }}>
      <div style={{
        display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', gap: 12,
      }}>
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{
            display: 'flex', alignItems: 'center', gap: 8,
          }}>
            <span style={{
              fontSize: 19, fontWeight: 700, color: t.label,
              letterSpacing: -0.4,
            }}>{b.name}</span>
            {isActive && (
              <span style={{
                fontSize: 10, fontWeight: 700, letterSpacing: 0.4,
                textTransform: 'uppercase', color: accent,
                background: theme === 'dark' ? `${accent}24` : `${accent}1A`,
                padding: '2px 6px', borderRadius: 5,
              }}>Active</span>
            )}
          </div>
          <div style={{
            fontSize: 13, color: t.label2, marginTop: 1, letterSpacing: -0.08,
          }}>{b.note}</div>
        </div>
        <div style={{ display: 'flex', gap: 12, flexShrink: 0 }}>
          <MiniStat n={stats.attack} l="ATK" theme={theme} />
          <MiniStat n={stats.defense} l="DEF" theme={theme} />
        </div>
      </div>

      <div style={{ marginTop: 12, display: 'flex', gap: 6 }}>
        {SLOT_KINDS.map(s => {
          const item = LD.byId[b.slots[s.key]];
          return (
            <div key={s.key} title={s.label} style={{
              flex: 1, height: 36, borderRadius: 8,
              background: item
                ? (theme === 'dark' ? `${accent}24` : `${accent}1A`)
                : t.fill,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}>
              <SlotGlyph kind={s.key} size={18}
                color={item ? accent : t.label3} />
            </div>
          );
        })}
      </div>

      <div style={{ marginTop: 12, display: 'flex', gap: 6, flexWrap: 'wrap' }}>
        {Object.entries(stats.skills).slice(0, 4).map(([n, l]) => (
          <SkillChip key={n} name={n} level={l} theme={theme} />
        ))}
        {Object.keys(stats.skills).length > 4 && (
          <span style={{
            fontSize: 12, color: t.label2,
            padding: '5px 8px',
          }}>+{Object.keys(stats.skills).length - 4}</span>
        )}
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Swipeable row — iOS-style. Drag left to reveal Edit + Delete.
// ─────────────────────────────────────────────────────────────
function SwipeableLoadoutRow({
  id, children, theme, accent, isActive,
  openId, setOpenId, onTap, onEdit, onDelete,
}) {
  const t = THEMES[theme];
  const ACTION_W = 80;
  const GAP = 8; // breathing room between card / actions / actions
  const actions = [
    {
      key: 'edit',
      label: 'Edit',
      bg: theme === 'dark' ? '#48484A' : '#A1A1A6',
      onClick: onEdit,
      icon: (
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
          <path d="M4 20h4l10-10-4-4L4 16v4z" stroke="#fff" strokeWidth="1.8"
            strokeLinecap="round" strokeLinejoin="round"/>
          <path d="M14 6l4 4" stroke="#fff" strokeWidth="1.8" strokeLinecap="round"/>
        </svg>
      ),
    },
    {
      key: 'delete',
      label: 'Delete',
      bg: '#FF3B30',
      onClick: onDelete,
      icon: (
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
          <path d="M5 7h14M9 7V5a1 1 0 011-1h4a1 1 0 011 1v2M7 7l1 13a2 2 0 002 2h4a2 2 0 002-2l1-13"
            stroke="#fff" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"/>
        </svg>
      ),
    },
  ];
  const MAX_OPEN = (ACTION_W + GAP) * actions.length;

  const open = openId === id;
  const startRef = React.useRef(null);
  const movedRef = React.useRef(false);
  const lockedAxisRef = React.useRef(null); // 'x' | 'y' | null
  const [dx, setDx] = React.useState(0);
  const [dragging, setDragging] = React.useState(false);

  const onPointerDown = (e) => {
    // ignore right-click
    if (e.button && e.button !== 0) return;
    startRef.current = { x: e.clientX, y: e.clientY };
    movedRef.current = false;
    lockedAxisRef.current = null;
    setDragging(true);
    try { e.currentTarget.setPointerCapture(e.pointerId); } catch (err) {}
  };

  const onPointerMove = (e) => {
    if (!startRef.current) return;
    const ddx = e.clientX - startRef.current.x;
    const ddy = e.clientY - startRef.current.y;

    // Lock axis on first significant movement
    if (!lockedAxisRef.current) {
      if (Math.abs(ddx) > 6 || Math.abs(ddy) > 6) {
        lockedAxisRef.current = Math.abs(ddx) > Math.abs(ddy) ? 'x' : 'y';
      }
    }
    if (lockedAxisRef.current !== 'x') return;

    movedRef.current = true;
    setDx(ddx);
  };

  const finishDrag = () => {
    if (!startRef.current) return;
    if (lockedAxisRef.current === 'x') {
      const finalOffset = (open ? -MAX_OPEN : 0) + dx;
      // Threshold: if dragged past half the panel (or fast enough), snap open
      if (finalOffset < -MAX_OPEN / 2) {
        setOpenId(id);
      } else {
        setOpenId(null);
      }
    }
    setDx(0);
    setDragging(false);
    startRef.current = null;
    // keep movedRef briefly so the synthetic click is suppressed
    setTimeout(() => { movedRef.current = false; }, 80);
  };

  const onPointerUp = () => finishDrag();
  const onPointerCancel = () => finishDrag();

  const onClick = (e) => {
    if (movedRef.current) {
      e.preventDefault();
      e.stopPropagation();
      return;
    }
    if (open) {
      // Tapping the body while open closes the actions instead of selecting
      setOpenId(null);
      return;
    }
    onTap && onTap();
  };

  // Compute translateX — clamp to [-MAX_OPEN, 0] with a tiny rubber-band
  const baseTx = open ? -MAX_OPEN : 0;
  let tx = dragging ? baseTx + dx : baseTx;
  if (tx > 0) tx = tx / 4;
  if (tx < -MAX_OPEN) tx = -MAX_OPEN + (tx + MAX_OPEN) / 4;

  // Reveal opacity for the action buttons grows as the row moves
  const revealRatio = Math.min(1, Math.abs(tx) / MAX_OPEN);

  // iOS Mail style: each action is its own rectangle that slides in from the
  // right alongside the card. Their combined visible width plus inter-gaps
  // equals -tx, so they appear to "follow" the card as it moves.
  const reveal = Math.max(0, -tx);
  const ratio = MAX_OPEN > 0 ? Math.min(1, reveal / MAX_OPEN) : 0;
  const perAction = ratio * ACTION_W;
  const curGap   = ratio * GAP;

  return (
    <div style={{
      position: 'relative',
      borderRadius: 22,
      // No overflow:hidden — the action rectangles sit OUTSIDE the card edge
      // so they each get their own corners, like Mail.
    }}>
      {/* Foreground card — drags left. The active border lives HERE so it
          travels with the card during the swipe. */}
      <div
        onPointerDown={onPointerDown}
        onPointerMove={onPointerMove}
        onPointerUp={onPointerUp}
        onPointerCancel={onPointerCancel}
        onClick={onClick}
        style={{
          position: 'relative',
          background: t.card,
          borderRadius: 22,
          border: isActive ? `2px solid ${accent}` : `2px solid transparent`,
          transition: dragging
            ? 'border-color 200ms'
            : 'transform 320ms cubic-bezier(.2,.85,.2,1), border-color 200ms',
          transform: `translateX(${tx}px)`,
          touchAction: 'pan-y',
          cursor: 'default',
          zIndex: 2,
          boxSizing: 'border-box',
        }}
      >
        {children}
      </div>

      {/* Action rectangles — laid out to the right of the card.
          Each one sits flush against the next, growing as the user swipes. */}
      {actions.map((a, i) => {
        // Stack from card edge outward: index 0 closest to card, last one rightmost.
        const rightOffset = (actions.length - 1 - i) * (perAction + curGap);
        return (
          <button
            key={a.key}
            onClick={(e) => {
              if (movedRef.current) { e.preventDefault(); e.stopPropagation(); return; }
              e.stopPropagation();
              a.onClick && a.onClick();
            }}
            style={{
              position: 'absolute',
              top: 0, bottom: 0,
              right: rightOffset,
              width: perAction,
              minWidth: 0,
              border: 0, appearance: 'none', cursor: 'default',
              background: a.bg, color: '#fff',
              borderRadius: 20,
              display: 'flex', flexDirection: 'column',
              alignItems: 'center', justifyContent: 'center', gap: 4,
              fontSize: 13, fontWeight: 600, letterSpacing: -0.08,
              overflow: 'hidden',
              opacity: reveal > 0 ? 1 : 0,
              pointerEvents: reveal > 8 ? 'auto' : 'none',
              transition: dragging ? 'none' : 'right 320ms cubic-bezier(.2,.85,.2,1), width 320ms cubic-bezier(.2,.85,.2,1), opacity 200ms',
            }}
          >
            {/* Inner wrapper kept at fixed width so icon/label don't squish
                while the rectangle is narrow during the early drag. */}
            <div style={{
              width: ACTION_W,
              display: 'flex', flexDirection: 'column',
              alignItems: 'center', justifyContent: 'center', gap: 4,
              opacity: Math.min(1, perAction / (ACTION_W * 0.6)),
              transition: dragging ? 'none' : 'opacity 200ms',
            }}>
              {a.icon}
              <span>{a.label}</span>
            </div>
          </button>
        );
      })}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Confirm dialog — iOS-style alert
// ─────────────────────────────────────────────────────────────
function ConfirmDialog({
  open, theme, title, message,
  confirmLabel = 'Confirm', cancelLabel = 'Cancel',
  destructive = false, onConfirm, onCancel,
}) {
  const t = THEMES[theme];
  // Don't intercept touches when closed
  return (
    <div style={{
      position: 'absolute', inset: 0, zIndex: 200,
      pointerEvents: open ? 'auto' : 'none',
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      padding: 24,
    }}>
      <div onClick={onCancel} style={{
        position: 'absolute', inset: 0,
        background: 'rgba(0,0,0,0.32)',
        opacity: open ? 1 : 0,
        transition: 'opacity 200ms ease',
      }} />
      <div style={{
        position: 'relative', width: 270,
        background: theme === 'dark' ? 'rgba(44,44,46,0.96)' : 'rgba(242,242,247,0.96)',
        backdropFilter: 'blur(28px)',
        WebkitBackdropFilter: 'blur(28px)',
        borderRadius: 14, overflow: 'hidden',
        opacity: open ? 1 : 0,
        transform: open ? 'scale(1)' : 'scale(0.92)',
        transition: 'transform 220ms cubic-bezier(.2,.85,.2,1), opacity 200ms',
        boxShadow: '0 18px 50px rgba(0,0,0,0.32)',
      }}>
        <div style={{ padding: '19px 16px 16px', textAlign: 'center' }}>
          <div style={{
            fontSize: 17, fontWeight: 600, color: t.label, letterSpacing: -0.4,
          }}>{title}</div>
          {message && (
            <div style={{
              fontSize: 13, color: t.label, marginTop: 4, lineHeight: 1.35,
              letterSpacing: -0.08,
            }}>{message}</div>
          )}
        </div>
        <div style={{
          display: 'flex',
          borderTop: `0.5px solid ${theme === 'dark' ? 'rgba(84,84,88,0.65)' : 'rgba(60,60,67,0.29)'}`,
        }}>
          <button onClick={onCancel} style={{
            flex: 1, padding: '11px 8px', border: 0,
            background: 'transparent', cursor: 'default',
            fontSize: 17, color: '#0A84FF', fontWeight: 400,
            letterSpacing: -0.43,
            borderRight: `0.5px solid ${theme === 'dark' ? 'rgba(84,84,88,0.65)' : 'rgba(60,60,67,0.29)'}`,
          }}>{cancelLabel}</button>
          <button onClick={onConfirm} style={{
            flex: 1, padding: '11px 8px', border: 0,
            background: 'transparent', cursor: 'default',
            fontSize: 17, fontWeight: 600,
            letterSpacing: -0.43,
            color: destructive ? '#FF3B30' : '#0A84FF',
          }}>{confirmLabel}</button>
        </div>
      </div>
    </div>
  );
}

function MiniStat({ n, l, theme }) {
  const t = THEMES[theme];
  return (
    <div style={{ textAlign: 'right' }}>
      <div style={{
        fontSize: 18, fontWeight: 700, color: t.label,
        fontVariantNumeric: 'tabular-nums', letterSpacing: -0.4,
        lineHeight: 1,
      }}>{n}</div>
      <div style={{
        fontSize: 10, fontWeight: 600, color: t.label2,
        letterSpacing: 0.4, textTransform: 'uppercase', marginTop: 2,
      }}>{l}</div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Equipment detail (sheet content)
// ─────────────────────────────────────────────────────────────
function EquipmentDetail({ item, theme, accent, build, onEquip, onChange, onClose, onPickJewel }) {
  if (!item) return null;
  const t = THEMES[theme];
  const isWeapon = item.kind === 'weapon';
  const isCharm = item.kind === 'charm';
  const isEquipped = build.slots[item.kind] === item.id;

  return (
    <div>
      {/* Header w/ close */}
      <div style={{
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        padding: '8px 16px 4px',
      }}>
        <span />
        <button onClick={onClose} style={{
          appearance: 'none', border: 0, padding: 0, background: 'transparent',
          width: 30, height: 30, borderRadius: 999,
          background: t.fill, display: 'flex', alignItems: 'center', justifyContent: 'center',
          cursor: 'default',
        }}>
          <svg width="11" height="11" viewBox="0 0 12 12">
            <path d="M2 2L10 10M10 2L2 10" stroke={t.label2} strokeWidth="1.8" strokeLinecap="round" />
          </svg>
        </button>
      </div>

      {/* Hero */}
      <div style={{
        display: 'flex', flexDirection: 'column', alignItems: 'center',
        gap: 12, padding: '8px 20px 24px',
      }}>
        <GlyphTile kind={item.kind} size={104} accent={accent} theme={theme} rounded={26} />
        <div style={{ textAlign: 'center' }}>
          <div style={{
            display: 'inline-flex', gap: 8, alignItems: 'center',
            fontSize: 11, fontWeight: 700, letterSpacing: 0.6,
            color: t.label2, textTransform: 'uppercase',
          }}>
            <span>{item.type || SLOT_KINDS.find(s => s.key === item.kind)?.label}</span>
            <span style={{
              padding: '1px 6px', borderRadius: 4,
              background: theme === 'dark' ? `${accent}24` : `${accent}1A`,
              color: accent, letterSpacing: 0.3,
            }}>R{item.rarity}</span>
          </div>
          <div style={{
            fontSize: 26, fontWeight: 700, color: t.label,
            letterSpacing: -0.5, marginTop: 4,
          }}>{item.name}</div>
        </div>
      </div>

      <Stack theme={theme} gap={20}>
        {/* Stats */}
        <Card theme={theme}>
          {isWeapon ? (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
              <StatBar label="Attack" value={item.attack} max={1500}
                color={SKILL_COLORS.red[theme]} theme={theme} />
              <StatBar label="Affinity" value={item.affinity} max={50} signed
                color={SKILL_COLORS.orange[theme]} theme={theme} suffix="%" />
              {item.element && (
                <StatBar label={item.element.type[0].toUpperCase() + item.element.type.slice(1) + ' element'}
                  value={item.element.value} max={500}
                  color={ELEMENT_COLORS[item.element.type][theme]} theme={theme} />
              )}
              <div>
                <div style={{
                  fontSize: 11, fontWeight: 600, color: t.label2,
                  letterSpacing: 0.3, textTransform: 'uppercase', marginBottom: 6,
                }}>Sharpness</div>
                <SharpnessGauge value={item.sharpness} theme={theme} />
              </div>
            </div>
          ) : isCharm ? (
            <div style={{ color: t.label2, fontSize: 14 }}>
              Charms grant skills only — no defense or resistances.
            </div>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
              <StatBar label="Defense" value={item.defense} max={200}
                color={accent} theme={theme} />
              {['fire','water','thunder','ice','dragon'].map(e => (
                <StatBar key={e}
                  label={e[0].toUpperCase() + e.slice(1) + ' Res'}
                  value={item[e]} max={10} signed
                  color={ELEMENT_COLORS[e][theme]} theme={theme} />
              ))}
            </div>
          )}
        </Card>

        {/* Skills */}
        {item.skills?.length > 0 && (
          <div>
            <SectionLabel theme={theme}>Skills</SectionLabel>
            <Card theme={theme} padding={0}>
              {item.skills.map(([n, l], i) => {
                const sk = LD.skills[n] || {};
                const c = SKILL_COLORS[sk.color || 'gray'][theme];
                return (
                  <div key={n} style={{
                    padding: '12px 16px',
                    borderBottom: i === item.skills.length - 1 ? 'none' : `0.5px solid ${t.sep}`,
                    display: 'flex', alignItems: 'center', gap: 12,
                  }}>
                    <span style={{ width: 8, height: 8, borderRadius: 999, background: c, flexShrink: 0 }} />
                    <div style={{ flex: 1 }}>
                      <div style={{ fontSize: 16, fontWeight: 590, color: t.label, letterSpacing: -0.32 }}>{n}</div>
                      {sk.desc && (
                        <div style={{ fontSize: 13, color: t.label2, marginTop: 1 }}>{sk.desc}</div>
                      )}
                    </div>
                    <div style={{
                      fontSize: 14, fontWeight: 700, color: c,
                      fontVariantNumeric: 'tabular-nums',
                    }}>+{l}</div>
                  </div>
                );
              })}
            </Card>
          </div>
        )}

        {/* Decoration slots — interactive */}
        {item.slots?.length > 0 && (
          <div>
            <SectionLabel theme={theme}>Decoration Slots</SectionLabel>
            <Card theme={theme} padding={0}>
              {item.slots.map((lv, idx) => {
                const key = `${item.id}-${idx}`;
                const jewelId = build.decorations[key];
                const jewel = jewelId ? LD.jewelsById[jewelId] : null;
                const sk = jewel ? LD.skills[jewel.skill] : null;
                const c = sk ? SKILL_COLORS[sk.color][theme] : t.label2;
                return (
                  <div key={idx} onClick={() => onPickJewel && onPickJewel(idx, lv)} style={{
                    display: 'flex', alignItems: 'center', gap: 12,
                    padding: '12px 16px', cursor: 'default',
                    borderBottom: idx === item.slots.length - 1 ? 'none' : `0.5px solid ${t.sep}`,
                  }}>
                    <div style={{
                      width: 38, height: 38, borderRadius: 10, flexShrink: 0,
                      background: jewel
                        ? (theme === 'dark' ? `${c}24` : `${c}18`)
                        : t.fill,
                      display: 'flex', alignItems: 'center', justifyContent: 'center',
                    }}>
                      <DecoSlot level={lv} filled={!!jewel} theme={theme} accent={c} size={18} />
                    </div>
                    <div style={{ flex: 1, minWidth: 0 }}>
                      <div style={{
                        fontSize: 11, fontWeight: 600, letterSpacing: 0.3,
                        color: t.label2, textTransform: 'uppercase',
                      }}>Slot {idx + 1} · Level {lv}</div>
                      {jewel ? (
                        <div style={{
                          fontSize: 16, fontWeight: 590, color: t.label,
                          letterSpacing: -0.32, marginTop: 1,
                          whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis',
                        }}>{jewel.name}</div>
                      ) : (
                        <div style={{
                          fontSize: 16, fontWeight: 500, color: t.label2,
                          letterSpacing: -0.32, marginTop: 1,
                        }}>Empty</div>
                      )}
                    </div>
                    {jewel && (
                      <span style={{
                        fontSize: 12, fontWeight: 600, color: c,
                        background: theme === 'dark' ? `${c}24` : `${c}18`,
                        padding: '4px 8px', borderRadius: 999,
                        whiteSpace: 'nowrap',
                      }}>+{jewel.amount} {jewel.skill}</span>
                    )}
                    <svg width="8" height="14" viewBox="0 0 8 14" style={{ flexShrink: 0 }}>
                      <path d="M1 1l6 6-6 6" stroke={t.label3} strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round"/>
                    </svg>
                  </div>
                );
              })}
            </Card>
          </div>
        )}

        {/* CTA */}
        <div style={{ padding: '4px 0 20px' }}>
          {isEquipped ? (
            <button onClick={onChange} style={{
              appearance: 'none', border: 0, width: '100%',
              background: accent, color: '#fff',
              padding: '14px 16px', borderRadius: 14,
              fontSize: 17, fontWeight: 600, letterSpacing: -0.43,
              cursor: 'default',
            }}>Change</button>
          ) : (
            <button onClick={onEquip} style={{
              appearance: 'none', border: 0, width: '100%',
              background: accent, color: '#fff',
              padding: '14px 16px', borderRadius: 14,
              fontSize: 17, fontWeight: 600, letterSpacing: -0.43,
              cursor: 'default',
            }}>Equip to {build.name}</button>
          )}
        </div>
      </Stack>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Jewel picker — choose a jewel for a single slot
// ─────────────────────────────────────────────────────────────
function JewelPicker({ slotLevel, slotIdx, itemId, build, theme, accent, onClose, onPick, onClear }) {
  const t = THEMES[theme];
  const equippedId = build.decorations[`${itemId}-${slotIdx}`];
  const fits = LD.jewels.filter(j => j.level <= slotLevel);
  const tooBig = LD.jewels.filter(j => j.level > slotLevel);
  const [query, setQuery] = React.useState('');
  const matches = (j) => j.name.toLowerCase().includes(query.toLowerCase())
                     || j.skill.toLowerCase().includes(query.toLowerCase());

  const renderJewel = (j, disabled = false) => {
    const sk = LD.skills[j.skill];
    const c = sk ? SKILL_COLORS[sk.color][theme] : t.label2;
    const selected = equippedId === j.id;
    return (
      <div key={j.id} onClick={() => !disabled && onPick(j.id)} style={{
        display: 'flex', alignItems: 'center', gap: 12,
        padding: '12px 16px', cursor: 'default',
        opacity: disabled ? 0.45 : 1,
        borderBottom: `0.5px solid ${t.sep}`,
      }}>
        <div style={{
          width: 38, height: 38, borderRadius: 10, flexShrink: 0,
          background: theme === 'dark' ? `${c}24` : `${c}18`,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}>
          <DecoSlot level={j.level} filled theme={theme} accent={c} size={18} />
        </div>
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{
            fontSize: 11, fontWeight: 600, letterSpacing: 0.3,
            color: t.label2, textTransform: 'uppercase',
          }}>Lv {j.level} · +{j.amount} {j.skill}</div>
          <div style={{
            fontSize: 16, fontWeight: 590, color: t.label,
            letterSpacing: -0.32, marginTop: 1,
          }}>{j.name}</div>
          {sk && (
            <div style={{ fontSize: 13, color: t.label2, marginTop: 2 }}>
              {sk.desc}
            </div>
          )}
        </div>
        {selected ? (
          <span style={{
            width: 22, height: 22, borderRadius: 999, background: accent,
            display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
          }}>
            <svg width="12" height="9" viewBox="0 0 12 9">
              <path d="M1 4.5L4.5 8L11 1" stroke="#fff" strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round"/>
            </svg>
          </span>
        ) : disabled ? (
          <span style={{
            fontSize: 11, fontWeight: 600, color: t.label2,
            background: t.fill, padding: '3px 7px', borderRadius: 999,
            whiteSpace: 'nowrap',
          }}>Slot too small</span>
        ) : null}
      </div>
    );
  };

  const filteredFits = fits.filter(matches);
  const filteredTooBig = tooBig.filter(matches);

  return (
    <div>
      <div style={{
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        padding: '8px 16px 4px',
      }}>
        <button onClick={onClose} style={{
          appearance: 'none', border: 0, padding: 0, background: 'transparent',
          color: accent, fontSize: 17, fontWeight: 500, cursor: 'default',
        }}>Cancel</button>
        <div style={{
          fontSize: 17, fontWeight: 600, color: t.label, textAlign: 'center',
        }}>
          Slot {slotIdx + 1}
          <div style={{ fontSize: 11, fontWeight: 500, color: t.label2, marginTop: 1 }}>
            Level {slotLevel}
          </div>
        </div>
        <button onClick={onClear} disabled={!equippedId} style={{
          appearance: 'none', border: 0, padding: 0, background: 'transparent',
          color: equippedId ? accent : t.label3,
          fontSize: 17, fontWeight: 500, cursor: 'default',
        }}>Clear</button>
      </div>
      <div style={{ padding: '12px 0 4px' }}>
        <SearchField value={query} onChange={setQuery} theme={theme} placeholder="Search jewels" />
      </div>
      <Stack theme={theme} gap={20} padding={16}>
        {filteredFits.length > 0 && (
          <div>
            <SectionLabel theme={theme}>Available</SectionLabel>
            <Card theme={theme} padding={0}>
              {filteredFits.map((j, i) => (
                <div key={j.id} style={i === filteredFits.length - 1 ? { '--last': 1 } : {}}>
                  {renderJewel(j)}
                </div>
              ))}
            </Card>
          </div>
        )}
        {filteredTooBig.length > 0 && (
          <div>
            <SectionLabel theme={theme}>Need a larger slot</SectionLabel>
            <Card theme={theme} padding={0}>
              {filteredTooBig.map(j => renderJewel(j, true))}
            </Card>
          </div>
        )}
        {!filteredFits.length && !filteredTooBig.length && (
          <Card theme={theme}>
            <div style={{ color: t.label2, textAlign: 'center', fontSize: 14 }}>
              No jewels match.
            </div>
          </Card>
        )}
      </Stack>
    </div>
  );
}

Object.assign(window, {
  Screen, LargeTitle, HeaderButton, Stack,
  BuildScreen, EquipmentScreen, StatsScreen, SavedScreen, EquipmentDetail,
  JewelPicker, ConfirmDialog,
});
